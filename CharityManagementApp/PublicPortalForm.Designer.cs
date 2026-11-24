namespace CharityManagementApp
{
    partial class PublicPortalForm
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            lblTitle = new Label();
            lblStats = new Label();
            dgvProjects = new DataGridView();
            btnRefresh = new Button();
            btnBack = new Button();
            ((System.ComponentModel.ISupportInitialize)dgvProjects).BeginInit();
            SuspendLayout();
            // 
            // lblTitle
            // 
            lblTitle.Font = new Font("Segoe UI", 14F, FontStyle.Bold);
            lblTitle.Location = new Point(20, 15);
            lblTitle.Name = "lblTitle";
            lblTitle.Size = new Size(760, 30);
            lblTitle.Text = "Публичный портал — благотворительные проекты";
            // 
            // lblStats
            // 
            lblStats.Font = new Font("Segoe UI", 10F);
            lblStats.ForeColor = Color.FromArgb(46, 160, 67);
            lblStats.Location = new Point(20, 50);
            lblStats.Name = "lblStats";
            lblStats.Size = new Size(760, 25);
            lblStats.Text = "Загрузка статистики...";
            // 
            // dgvProjects
            // 
            dgvProjects.AllowUserToAddRows = false;
            dgvProjects.AllowUserToDeleteRows = false;
            dgvProjects.ReadOnly = true;
            dgvProjects.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvProjects.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvProjects.Location = new Point(20, 85);
            dgvProjects.Name = "dgvProjects";
            dgvProjects.Size = new Size(760, 320);
            // 
            // btnRefresh
            // 
            btnRefresh.Location = new Point(20, 420);
            btnRefresh.Name = "btnRefresh";
            btnRefresh.Size = new Size(140, 35);
            btnRefresh.Text = "Обновить";
            btnRefresh.Click += btnRefresh_Click;
            // 
            // btnBack
            // 
            btnBack.Location = new Point(640, 420);
            btnBack.Name = "btnBack";
            btnBack.Size = new Size(140, 35);
            btnBack.Text = "Назад к входу";
            btnBack.Click += btnBack_Click;
            // 
            // PublicPortalForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 470);
            Controls.Add(lblTitle);
            Controls.Add(lblStats);
            Controls.Add(dgvProjects);
            Controls.Add(btnRefresh);
            Controls.Add(btnBack);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            Name = "PublicPortalForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Публичный интерфейс";
            ((System.ComponentModel.ISupportInitialize)dgvProjects).EndInit();
            ResumeLayout(false);
        }

        private Label lblTitle;
        private Label lblStats;
        private DataGridView dgvProjects;
        private Button btnRefresh;
        private Button btnBack;

        #endregion
    }
}
