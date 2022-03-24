package 
{
    import flash.geom.Rectangle;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.net.registerClassAlias;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    public class SaveData 
    {
        public var bounds:Rectangle; //to save where an object is on the stage
        //public var classType:Class; //to save what kind of object it is
        public var name:String;

        //you could add in more proterties, like rotation etc


        public function SaveData() 
        {
            
        }
    }
}