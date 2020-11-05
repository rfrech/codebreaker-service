package edu.cnm.deepdive.codebreaker.service;

import edu.cnm.deepdive.codebreaker.model.dao.MatchRepository;
import edu.cnm.deepdive.codebreaker.model.entity.Game;
import edu.cnm.deepdive.codebreaker.model.entity.Match;
import edu.cnm.deepdive.codebreaker.model.entity.User;
import java.util.List;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatchService {

  private final MatchRepository matchRepository;
  private final Random rng;

  @Autowired
  public MatchService(MatchRepository matchRepository, Random rng) {
    this.matchRepository = matchRepository;
    this.rng = rng;
  }

  public Match startMatch(Match match, User user) {
    char[] poolCharacters = match.getPool().toCharArray();
    match.setOriginator(user);
    List<Game> games = match.getGames();
    StringBuilder builder = new StringBuilder(match.codeLength());
    for (int i = 0; i < match.getGameCount(); i++) {
      Game game = new Game();
      game.setMatch(match);
      games.add(game);
      for (int j = 0; j < match.codeLength(); j++) {
        builder.append(poolCharacters[rng.nextInt(poolCharacters.length)]);
      }
      game.setCode(builder.toString());
      builder.setLength(0);
      games.add(game);
    }
    matchRepository.save(match);
    return match;
  }
}
