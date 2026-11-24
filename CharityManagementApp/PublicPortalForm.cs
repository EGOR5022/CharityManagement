namespace CharityManagementApp
{
    /// <summary>
    /// Публичный интерфейс — просмотр данных без регистрации (гость).
    /// Только чтение: проекты, сборы, статистика.
    /// </summary>
    public partial class PublicPortalForm : Form
    {
        public PublicPortalForm()
        {
            InitializeComponent();
            LoadPublicData();
        }

        private void LoadPublicData()
        {
            if (!DatabaseConnection.TestConnection(out string error))
            {
                MessageBox.Show("База данных недоступна:\n" + error,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                // Список активных проектов (публичная информация)
                dgvProjects.DataSource = DatabaseConnection.ExecuteQuery(@"
                    SELECT п.Название      AS Проект,
                           к.Название      AS Категория,
                           п.ЦелеваяСумма  AS Цель,
                           п.Собрано       AS Собрано,
                           п.Статус        AS Статус
                    FROM dbo.Проекты п
                    LEFT JOIN dbo.Категории к ON к.Id = п.CategoryId");

                // Общая статистика
                object? total = DatabaseConnection.ExecuteScalar(
                    "SELECT ISNULL(SUM(Сумма), 0) FROM dbo.Платежи");
                object? donors = DatabaseConnection.ExecuteScalar(
                    "SELECT COUNT(*) FROM dbo.Доноры");
                lblStats.Text = $"Всего собрано: {total} ₽   |   Доноров: {donors}";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки данных: " + ex.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnRefresh_Click(object? sender, EventArgs e)
        {
            LoadPublicData();
        }

        private void btnBack_Click(object? sender, EventArgs e)
        {
            var login = new LoginForm();
            Hide();
            login.ShowDialog();
            Close();
        }
    }
}
