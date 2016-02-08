class HighScores
{
  String player;
  float score;
  
  HighScores(String line)
  {
    String[] parts = line.split(",");
    player = parts[0];
    score = Float.parseFloat(parts[1]);
  }
}
