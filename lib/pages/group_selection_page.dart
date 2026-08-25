import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/pages/main_layout.dart';

class GroupSelectionPage extends StatefulWidget {
  const GroupSelectionPage({super.key});

  @override
  State<GroupSelectionPage> createState() => _GroupSelectionPageState();
}

class _GroupSelectionPageState extends State<GroupSelectionPage> {
  bool _isLoading = false;
  bool _isInitialLoading = true;
  List<Map<String, dynamic>> _myGroups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() => _isInitialLoading = true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception("No auth");

      final response = await Supabase.instance.client
          .from('group_members')
          .select('''
            group_id,
            monedas_del_grupo,
            groups (
              id,
              nombre,
              descripcion,
              codigo_invitacion
            )
          ''')
          .eq('user_id', userId);

      if (mounted) {
        setState(() {
          _myGroups = List<Map<String, dynamic>>.from(response);
          _isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isInitialLoading = false);
      }
    }
  }

  Future<void> _createGroup(String nombre, String descripcion) async {
    if (nombre.trim().isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception("Usuario no autenticado");

      final groupResponse = await Supabase.instance.client
          .from('groups')
          .insert({'nombre': nombre.trim(), 'descripcion': descripcion.trim()})
          .select()
          .single();

      final groupId = groupResponse['id'];

      await Supabase.instance.client.from('group_members').insert({
        'group_id': groupId,
        'user_id': userId,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Grupo "\$nombre" creado exitosamente!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        await _loadGroups();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error al crear el grupo. Inténtalo de nuevo.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _joinGroup(String codigo) async {
    if (codigo.trim().isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception("Usuario no autenticado");

      final groupResponse = await Supabase.instance.client
          .from('groups')
          .select('id, nombre')
          .eq('codigo_invitacion', codigo.trim())
          .maybeSingle();

      if (groupResponse == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Código de invitación no válido o no existe.',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        return;
      }

      final groupId = groupResponse['id'];
      final groupName = groupResponse['nombre'];

      await Supabase.instance.client.from('group_members').insert({
        'group_id': groupId,
        'user_id': userId,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Te has unido a "\$groupName"!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        await _loadGroups();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Ya perteneces a este grupo o hubo un error.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showCreateGroupModal() {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crear un nuevo grupo',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: _inputDecoration('Nombre del grupo', Icons.group),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: _inputDecoration(
                  'Descripción (Opcional)',
                  Icons.description,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: _buttonStyle(),
                onPressed: () {
                  Navigator.pop(context);
                  _createGroup(nameController.text, descController.text);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Crear Grupo', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showJoinGroupModal() {
    final codeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Unirse a un grupo',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Ingresa el código de 8 caracteres que te compartieron.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: codeController,
                maxLength: 8,
                decoration: _inputDecoration(
                  'Código de Invitación',
                  Icons.vpn_key,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: _buttonStyle(),
                onPressed: () {
                  Navigator.pop(context);
                  _joinGroup(codeController.text);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Unirse', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      prefixIcon: Icon(icon, color: colorScheme.primary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withAlpha(76),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
    );
  }

  void _enterGroup(String groupId) {
    // Aquí más adelante podríamos guardar en un estado/proveedor global en qué grupo entró
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainLayout()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tus Grupos',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
            color: colorScheme.error,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_isInitialLoading)
            const Center(child: CircularProgressIndicator())
          else if (_myGroups.isEmpty)
            _buildEmptyState(theme, colorScheme)
          else
            _buildGroupList(theme, colorScheme),

          if (_isLoading)
            Container(
              color: colorScheme.surface.withAlpha(150),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      floatingActionButton: _myGroups.isNotEmpty && !_isInitialLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'join_btn',
                  onPressed: _showJoinGroupModal,
                  icon: const Icon(Icons.login_rounded),
                  label: const Text('Unirse'),
                  backgroundColor: colorScheme.secondaryContainer,
                  foregroundColor: colorScheme.onSecondaryContainer,
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  heroTag: 'create_btn',
                  onPressed: _showCreateGroupModal,
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo Grupo'),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildEmptyState(ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.groups_rounded,
            size: 100,
            color: colorScheme.primary.withAlpha(150),
          ),
          const SizedBox(height: 32),
          Text(
            'Aún no tienes un grupo activo',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Crea uno nuevo para invitar a tus amigos o únete a uno existente usando un código de invitación.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          OutlinedButton.icon(
            icon: const Icon(Icons.add_circle_outline),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Crear un nuevo grupo',
                style: TextStyle(fontSize: 16),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.primary, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: _showCreateGroupModal,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.login_rounded),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Tengo un código de invitación',
                style: TextStyle(fontSize: 16),
              ),
            ),
            style: _buttonStyle(),
            onPressed: _showJoinGroupModal,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupList(ThemeData theme, ColorScheme colorScheme) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 160),
      itemCount: _myGroups.length,
      itemBuilder: (context, index) {
        final item = _myGroups[index];
        final groupData = item['groups'];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _enterGroup(groupData['id']),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.group,
                      color: colorScheme.onPrimaryContainer,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupData['nombre'] ?? 'Sin nombre',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (groupData['descripcion'] != null &&
                            groupData['descripcion'].toString().isNotEmpty)
                          Text(
                            groupData['descripcion'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.vpn_key,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              groupData['codigo_invitacion'] ?? '',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.monetization_on,
                              size: 14,
                              color: Colors.amber[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item['monedas_del_grupo'].toString(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.amber[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
