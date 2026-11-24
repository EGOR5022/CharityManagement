namespace CharityManagementApp
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object? sender, EventArgs e)
        {
            string login = txtLogin.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Введите логин и пароль.", "Внимание",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            // Проверка подключения к БД
            if (!DatabaseConnection.TestConnection(out string error))
            {
                MessageBox.Show("Не удалось подключиться к базе данных:\n" + error,
                    "Ошибка подключения", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                // Аутентификация через таблицу Сотрудник (CRM-функционал)
                var table = DatabaseConnection.ExecuteQuery(
                    @"SELECT Id, ФИО, Должность FROM dbo.Сотрудники
                      WHERE Логин = @login AND Пароль = @password",
                    new Microsoft.Data.SqlClient.SqlParameter("@login", login),
                    new Microsoft.Data.SqlClient.SqlParameter("@password", password));

                if (table.Rows.Count == 0)
                {
                    MessageBox.Show("Неверный логин или пароль.", "Ошибка входа",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                // Запоминаем вошедшего сотрудника и открываем главную форму
                CurrentUser.Login(login);
                var mainForm = new MainForm();
                Hide();
                mainForm.ShowDialog();
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при входе: " + ex.Message, "Ошибка",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnGuest_Click(object? sender, EventArgs e)
        {
            // Публичный интерфейс — просмотр данных без регистрации
            CurrentUser.LoginAsGuest();
            var portal = new PublicPortalForm();
            Hide();
            portal.ShowDialog();
            Close();
        }

        private void LoginForm_KeyDown(object? sender, KeyEventArgs e)
        {
            // Enter = войти, F1 = публичный портал
            if (e.KeyCode == Keys.Enter)
            {
                btnLogin_Click(this, EventArgs.Empty);
                e.SuppressKeyPress = true;
            }
            else if (e.KeyCode == Keys.Escape)
            {
                Close();
            }
        }
    }
}
