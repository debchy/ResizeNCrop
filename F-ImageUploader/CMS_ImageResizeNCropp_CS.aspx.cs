using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class F_ImageUploader_CMS_ImageResizeNCropp_CS : System.Web.UI.Page
{
    
    protected Int16 resizedWidth;
    protected Int16 resizedHeight;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ClearHeaders();
        Response.AppendHeader("Cache-Control", "no-cache");
        ////HTTP 1.1
        Response.AppendHeader("Cache-Control", "private");
        //// HTTP 1.1
        Response.AppendHeader("Cache-Control", "no-store");
        //// HTTP 1.1
        Response.AppendHeader("Cache-Control", "must-revalidate");
        //// HTTP 1.1
        Response.AppendHeader("Cache-Control", "max-stale=0");
        //// HTTP 1.1 
        Response.AppendHeader("Cache-Control", "post-check=0");
        //// HTTP 1.1 
        Response.AppendHeader("Cache-Control", "pre-check=0");
        //// HTTP 1.1 
        Response.AppendHeader("Pragma", "no-cache");
        //// HTTP 1.1 
        Response.AppendHeader("Keep-Alive", "timeout=3, max=993");
        // // HTTP 1.1 
        Response.AppendHeader("Expires", "Mon, 26 Jul 1997 05:00:00 GMT");
        // // HTTP 1.1
        try
        {
            resizedWidth = !string.IsNullOrEmpty(Request.QueryString["Width"]) ? Int16.Parse(Request.QueryString["Width"]) : (Int16)700;
        }
        catch (Exception ex)
        {
            resizedWidth = 700;
        }
        try
        {
            resizedHeight = !string.IsNullOrEmpty(Request.QueryString["height"]) ? Int16.Parse(Request.QueryString["height"]) : (Int16)200;
        }
        catch (Exception ex)
        {
            resizedHeight = 200;
        }

        if (resizedWidth >= resizedHeight)
        {
            canvasSource.Attributes.Add("Width", resizedWidth.ToString());
        }
        else
        {
            canvasSource.Attributes.Add("height", resizedHeight.ToString());
        }
    }

    protected void Upload(object sender, System.EventArgs e)
    {
        string base64 = Request.Form["imgCropped"];
        byte[] bytes = Convert.FromBase64String(base64.Split(new char[] { ',' })[1]);

        string c = null;
        string filename = null;
        c =DateTime.Now.ToString("ddMMyyyyhhmmss")  + ".png";
        filename = "Content/Cropped_" + c;

        System.Drawing.Image image__1 = default(System.Drawing.Image);
        using (MemoryStream ms = new MemoryStream(bytes))
        {
            image__1 = System.Drawing.Image.FromStream(ms);
        }
        image__1.Save(System.AppDomain.CurrentDomain.BaseDirectory.ToString() + "/Admin/" + filename);

        //IO.File.WriteAllBytes(System.AppDomain.CurrentDomain.BaseDirectory() & "/Admin/" & filename, Convert.FromBase64String(base64.Split(",")(1)))

        //Using stream As New IO.FileStream(Server.MapPath("~/Admin/" & filename), IO.FileMode.Create)
        //    stream.Write(bytes, 0, bytes.Length)
        //    stream.Flush()
        //End Using

        ltrMessage.Text = "<div class='alert alert-success' role='alert'>Successfully Uploaded</div>";
        imgResultImage.ImageUrl = "~/Admin/" + filename;

        ClientScript.RegisterStartupScript(this.GetType(), "uploaded", "<script>$('#pnlResult').show();$('#pnlCrpper').hide(); $('#pnlUpload').hide();   parent.$.fancybox.close();  </script>");
    }
    

}