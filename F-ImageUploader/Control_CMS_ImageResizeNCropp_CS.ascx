<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Control_CMS_ImageResizeNCropp_CS.ascx.cs" Inherits="Control_CMS_ImageResizeNCropp_CS" %>
<div class="row">
    <div class="col-xs-12">
        <asp:Image ID="imgResultImage" runat="server" style="display:none;border: rgba(128, 128, 128, 0.33) dashed 1px;" />
        <asp:HiddenField ID="hdnResultImage" runat="server" />
        
    </div>
    <div class="col-xs-12" style="margin-top:5px;">
        <a href='/F-ImageUploader/CMS_ImageResizeNCropp_CS.aspx?controlID=<%= this.ID %>&width=<%= Width %>&height=<%= Height %>'  
            class="imageUpload btn btn-primary fancybox.iframe <%= CssClass %>" ><%= ButtonName %></a>                
    </div>
</div>