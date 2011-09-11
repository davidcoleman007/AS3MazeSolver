package assets
{
	public class Assets
	{
		[Embed(source="assets/maze.png")]
		public static var MazeMaterial:Class;

		[Embed(source="assets/smiley.gif")]
		public static var AvatarMaterial:Class;
		
		[Embed(source="assets/grass_pattern2.jpg")]
		public static var GrassPattern2:Class;
		
		[Embed(source="assets/dirt_1.jpg")]
		public static var Dirt1:Class;
		
		public function Assets()
		{
		}
	}
}