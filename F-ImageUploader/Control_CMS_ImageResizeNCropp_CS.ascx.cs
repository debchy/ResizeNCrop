using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Control_CMS_ImageResizeNCropp_CS : System.Web.UI.UserControl
{



    private Int16 width_ = 600;
    public Int16 Width
    {
        get { return width_; }
        set
        {
            try
            {
                width_ = value != 0 ? value : (short)600;
            }
            catch (Exception ex)
            {
                width_ = 600;
            }

        }
    }

    private Int16 height_ = 480;
    public Int16 Height
    {
        get { return height_; }
        set
        {
            try
            {
                height_ = value!=0 ? value : (short)480;
            }
            catch (Exception ex)
            {
                height_ = 480;
            }
        }
    }
    

    private string cssClass_ = "";
    public string CssClass
    {
        get { return cssClass_; }
        set { cssClass_ = value; }
    }

    private string buttonName_ = "Upload Image";
    public string ButtonName
    {
        get { return buttonName_; }
        set { buttonName_ = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    
}