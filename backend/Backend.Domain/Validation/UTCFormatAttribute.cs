using System.ComponentModel.DataAnnotations;

namespace Backend.Domain.Validation
{
    public class UTCFormatAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            if (value is DateTime dateValue)
            {
                return dateValue.Kind == DateTimeKind.Utc;
            }
            return true;
        }
    }
}