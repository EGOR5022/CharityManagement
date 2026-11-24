namespace CharityManagementApp
{
    /// <summary>
    /// Главная форма для сотрудника (после авторизации).
    /// Модули: финансы, проекты, волонтёры, отчётность — будут добавлены далее.
    /// </summary>
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            lblWelcome.Text = $"Добро пожаловать, {CurrentUser.LoginName}!";
        }

        private void btnLogout_Click(object? sender, EventArgs e)
        {
            CurrentUser.Logout();
            var login = new LoginForm();
            Hide();
            login.ShowDialog();
            Close();
        }
    }
}
