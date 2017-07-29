using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_CMS_ImageResizeNCropp_CS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string script = "function GetImage(imageURL) {$('img[id=\""+ this.ID + "_imgResultImage\"]').attr(\"src\", imageURL).show();};";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script_" + this.ID, script, true); }
    }
}