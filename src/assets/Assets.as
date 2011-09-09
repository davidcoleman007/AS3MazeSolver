package assets
{
	public class Assets
	{
		[Embed(source="assets/maze.png")]
		public static var MazeMaterial:Class;

		[Embed(source="assets/duckCM.png")]
		public static var DuckSkin:Class;
		
		[Embed(source="assets/smiley.gif")]
		public static var AvatarMaterial:Class;
		
		public function Assets()
		{
		}
	}
}