# Buck

This is a command line game written in Ruby by ChatGPT. In this game, players must fill a series of buckets with numbers drawn from a specified range. The game continues until all buckets are filled validly or there is no valid bucket for a drawn number.

## Rules

1. A number of ordered buckets and a range of numbers (from 0 to X) are selected at the start of the game.
2. Each round, a random whole number is selected from the range.
3. Players must decide which bucket to place the number in.
4. The chosen bucket is only valid if all buckets to the right contain numbers which are higher and all buckets to the left contain numbers which are lower.
5. Buckets which are empty (do not contain a number) are not considered.
6. Adjacent buckets may contain duplicate numbers.
7. In following rounds, players must continue selecting random numbers from the range in order to fill all buckets.
8. The players win once all buckets are filled validly.
9. The players lose if a random number is drawn for which there is no valid bucket.

## How to Run

This game is containerized using Docker, and can be run using the following commands:

```bash
docker run -it ghcr.io/thomascountz/buck:main
```
