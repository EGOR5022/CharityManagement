namespace CharityManagementApp
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            // Стартуем с формы логина: вход сотрудника или публичный интерфейс (гость)
            Application.Run(new LoginForm());
        }
    }
}