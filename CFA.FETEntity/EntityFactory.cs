using System;
using System.Reflection;

namespace CFA.FETEntity
{
    public sealed class EntityFactory
    {

        public static IBaseEntity CreateEntity(string classType)
        {
            Type t = Type.GetType(classType);
            ConstructorInfo ctor = t.GetConstructor(Type.EmptyTypes);

            IBaseEntity entity = (IBaseEntity)ctor.Invoke(null);

            return entity;
        }
        public static Type CreateType(string type)
        {
            return Assembly.GetExecutingAssembly().GetType(type);
        }
    }
    
}
