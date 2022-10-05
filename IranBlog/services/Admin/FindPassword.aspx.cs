/*
	All rights reserved to Alireza Poshtkohi (c) 1999-2023.
	Email: arp@poshtkohi.info
	Website: http://www.poshtkohi.info
*/

using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Data.SqlClient;
using AlirezaPoshtkoohiLibrary;

namespace services
{
	/// <summary>
	/// Summary description for FindPassword.
	/// </summary>
	public partial class FindPassword : System.Web.UI.Page
	{
		//----------------------------------------------------------------------------------
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}
		//----------------------------------------------------------------------------------
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
		//----------------------------------------------------------------------------------
		protected void find_Click(object sender, System.EventArgs e)
		{
			if(this.Request.Form["verify"] == "000")
			{
				SqlConnection connection = new SqlConnection(constants.ConnectionStringSQLDatabase);
				connection.Open();
				SqlCommand command = connection.CreateCommand();
				command.Connection = connection;
				command.CommandText = string.Format("SELECT username,password FROM {0} WHERE subdomain='{1}'", constants.SQLUsersInformationTableName, this.Request.Form["subdomain"]);
				SqlDataReader reader = command.ExecuteReader();
				if(reader.Read())
				{
                    this.username.Text = reader.GetString(0);
					this.password.Text = reader.GetString(1);
				}
				else
					this.password.Text = "Not Found.";
				reader.Close();
				command.Dispose();
			}
			else
				this.password.Text = "Incorrect Verify Code.";
		}
		//----------------------------------------------------------------------------------
	}
}
