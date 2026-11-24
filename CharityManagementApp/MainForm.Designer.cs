namespace CharityManagementApp
{
    partial class MainForm
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
            lblWelcome = new Label();
            btnLogout = new Button();
            SuspendLayout();
            // 
            // lblWelcome
            // 
            lblWelcome.Font = new Font("Segoe UI", 14F, FontStyle.Bold);
            lblWelcome.Location = new Point(30, 30);
            lblWelcome.Name = "lblWelcome";
            lblWelcome.Size = new Size(540, 40);
            lblWelcome.Text = "Добро пожаловать!";
            // 
            // btnLogout
            // 
            btnLogout.Location = new Point(30, 90);
            btnLogout.Name = "btnLogout";
            btnLogout.Size = new Size(160, 35);
            btnLogout.Text = "Выйти (сменить пользователя)";
            btnLogout.Click += btnLogout_Click;
            // 
            // MainForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(lblWelcome);
            Controls.Add(btnLogout);
            Name = "MainForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "CharityManagementApp — Управление благотворительной деятельностью";
            ResumeLayout(false);
        }

        private Label lblWelcome;
        private Button btnLogout;

        #endregion
    }
}
