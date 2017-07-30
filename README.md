# ResizeNCrop
## developer: Debashis Chowdhury
## published at: https://www.codeproject.com/Articles/1198920/Create-ASP-net-control-for-Image-resizer-and-cropp
Resizing is not anymore clients headache. Client can upload any size of image. We are resizing according to our need and giving them option to crop the image according to aspect ratio. 

Here I am using JCrop jquery plugins(http://jcrop.org/) for cropping and I developed a algorithm to resize the input image keeping it's ratio. Also, I made a custom control on asp.net to give a simple solution to integrate into .net projects and simple way to handle for the user.

## Folder Structure
The F-ImageUploader is the folder which contains all the required files for the control. 

ImageResizeNCrop.js contains all javascript code for resizing, cropping and saving.
A asp.net Handler file(HandlerImageUploader.ashx) is used to save the file with ajax
CMS_ImageResizeNCropp_CS.aspx and CMS_ImageResizeNCropp_VB.aspx are the container for control which will open in fancybox iframe.
ASP.net custom controller Control_CMS_ImageResizeNCropp_CS.ascx and Control_CMS_ImageResizeNCropp_VB.ascx are used to quickly plug and play the control by dragging from VS Solution Explorer.
Images will save on /Admin/Content folder.
