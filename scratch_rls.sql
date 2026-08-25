-- Eliminar políticas anteriores por si acaso
DROP POLICY IF EXISTS "Permitir crear grupos a usuarios autenticados" ON public.groups;
DROP POLICY IF EXISTS "Permitir leer grupos a usuarios autenticados" ON public.groups;
DROP POLICY IF EXISTS "Permitir insertarse a sí mismo" ON public.group_members;
DROP POLICY IF EXISTS "Permitir leer miembros" ON public.group_members;

-- Políticas para GROUPS
CREATE POLICY "Permitir crear grupos a usuarios autenticados" ON public.groups 
FOR INSERT TO authenticated 
WITH CHECK (true);

CREATE POLICY "Permitir leer grupos a usuarios autenticados" ON public.groups 
FOR SELECT TO authenticated 
USING (true);

-- Políticas para GROUP_MEMBERS
CREATE POLICY "Permitir insertarse a sí mismo" ON public.group_members 
FOR INSERT TO authenticated 
WITH CHECK (user_id = auth.uid());

CREATE POLICY "Permitir leer miembros" ON public.group_members 
FOR SELECT TO authenticated 
USING (true);

