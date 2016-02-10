class HighScores
{
  String player;
  float score;
  
  HighScores(String line)
  {
    String[] parts = line.split(",");
    score = Float.parseFloat(parts[0]);
  }
}
