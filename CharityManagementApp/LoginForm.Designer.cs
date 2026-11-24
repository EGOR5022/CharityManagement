namespace CharityManagementApp
{
    partial class LoginForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
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
            lblLogin = new Label();
            txtLogin = new TextBox();
            lblPassword = new Label();
            txtPassword = new TextBox();
            btnLogin = new Button();
            btnGuest = new Button();
            SuspendLayout();
            // 
            // lblTitle
            // 
            lblTitle.Font = new Font("Segoe UI", 16F, FontStyle.Bold);
            lblTitle.Location = new Point(30, 25);
            lblTitle.Name = "lblTitle";
            lblTitle.Size = new Size(340, 35);
            lblTitle.Text = "Благотворительность";
            lblTitle.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // lblLogin
            // 
            lblLogin.AutoSize = true;
            lblLogin.Location = new Point(60, 85);
            lblLogin.Name = "lblLogin";
            lblLogin.Text = "Логин:";
            // 
            // txtLogin
            // 
            txtLogin.Location = new Point(60, 105);
            txtLogin.Name = "txtLogin";
            txtLogin.Size = new Size(280, 23);
            // 
            // lblPassword
            // 
            lblPassword.AutoSize = true;
            lblPassword.Location = new Point(60, 145);
            lblPassword.Name = "lblPassword";
            lblPassword.Text = "Пароль:";
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(60, 165);
            txtPassword.Name = "txtPassword";
            txtPassword.PasswordChar = '*';
            txtPassword.Size = new Size(280, 23);
            // 
            // btnLogin
            // 
            btnLogin.BackColor = Color.FromArgb(46, 160, 67);
            btnLogin.FlatStyle = FlatStyle.Flat;
            btnLogin.ForeColor = Color.White;
            btnLogin.Location = new Point(60, 210);
            btnLogin.Name = "btnLogin";
            btnLogin.Size = new Size(280, 40);
            btnLogin.Text = "Войти";
            btnLogin.UseVisualStyleBackColor = false;
            btnLogin.Click += btnLogin_Click;
            // 
            // btnGuest
            // 
            btnGuest.BackColor = Color.FromArgb(9, 105, 218);
            btnGuest.FlatStyle = FlatStyle.Flat;
            btnGuest.ForeColor = Color.White;
            btnGuest.Location = new Point(60, 260);
            btnGuest.Name = "btnGuest";
            btnGuest.Size = new Size(280, 40);
            btnGuest.Text = "Публичный интерфейс (Гость)";
            btnGuest.UseVisualStyleBackColor = false;
            btnGuest.Click += btnGuest_Click;
            // 
            // LoginForm
            // 
            AcceptButton = btnLogin;
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.White;
            ClientSize = new Size(400, 330);
            Controls.Add(lblTitle);
            Controls.Add(lblLogin);
            Controls.Add(txtLogin);
            Controls.Add(lblPassword);
            Controls.Add(txtPassword);
            Controls.Add(btnLogin);
            Controls.Add(btnGuest);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            KeyPreview = true;
            MaximizeBox = false;
            Name = "LoginForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Вход в систему";
            KeyDown += LoginForm_KeyDown;
            ResumeLayout(false);
            PerformLayout();
        }

        private Label lblTitle;
        private Label lblLogin;
        private TextBox txtLogin;
        private Label lblPassword;
        private TextBox txtPassword;
        private Button btnLogin;
        private Button btnGuest;

        #endregion
    }
}
