using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;


public partial class CS : System.Web.UI.Page
{
protected void Upload(object sender, EventArgs e)
{
    string base64 = Request.Form["imgCropped"];
    byte[] bytes = Convert.FromBase64String(base64.Split(',')[1]);
    using (System.IO.FileStream stream = new System.IO.FileStream(Server.MapPath("~/Images/Cropped.png"), System.IO.FileMode.Create))
    {
        stream.Write(bytes, 0, bytes.Length);
        stream.Flush();
    }
}
}