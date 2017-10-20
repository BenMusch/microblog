alias Microblog.Repo
alias Microblog.Social.User
alias Microblog.Social.Message

Repo.delete_all(Message)
Repo.delete_all(User)

user1 = %User{email: "benmuschol@gmail.com", handle: "benmusch",
  human_name: "Ben Muschol", password: "password", password_confirmation: "password"}
user1 = Repo.insert!(user1)

user2 = %User{email: "j.aoun@northeastern.edu", handle: "aoun",
  human_name: "Joseph Aoun", password: "password", password_confirmation: "password"}
user2 = Repo.insert!(user2)

user3 = %User{email: "licoln@chaffee2020.com", handle: "the_chaffe",
  human_name: "Lincoln Chaffee", password: "password", password_confirmation: "password"}
user3 = Repo.insert!(user3)

Repo.insert!(%Message{content: "Buy my new book Robot Proof on Amazon.com!",
  user_id: user2.id})
Repo.insert!(%Message{content: "My front-end doesn't support emoji :(",
  user_id: user1.id})
Repo.insert!(%Message{content: "I am a block of granite.", user_id: user3.id})
