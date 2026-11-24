namespace CharityManagementApp
{
    /// <summary>
    /// Хранит информацию о текущем пользователе (сотрудник или гость).
    /// </summary>
    public static class CurrentUser
    {
        public static string LoginName { get; private set; } = string.Empty;
        public static bool IsGuest { get; private set; } = true;

        public static void Login(string login)
        {
            LoginName = login;
            IsGuest = false;
        }

        public static void LoginAsGuest()
        {
            LoginName = "Гость";
            IsGuest = true;
        }

        public static void Logout()
        {
            LoginName = string.Empty;
            IsGuest = true;
        }
    }
}
