alias Microblog.Repo
alias Microblog.Social.User
alias Microblog.Social.Message

Repo.delete_all(Message)
Repo.delete_all(User)

user1 = %User{email: "benmuschol@gmail.com", handle: "benmusch",
  human_name: "Ben Muschol"}
user1 = Repo.insert!(user1)

user2 = %User{email: "j.aoun@northeastern.edu", handle: "aoun",
  human_name: "Joseph Aoun"}
user2 = Repo.insert!(user2)

user3 = %User{email: "licoln@chaffee2020.com", handle: "the_chaffe",
  human_name: "Lincoln Chaffee"}
user3 = Repo.insert!(user3)

Repo.insert!(%Message{content: "Buy my new book Robot Proof on Amazon.com!",
  user_id: user2.id})
Repo.insert!(%Message{content: "I can't believe Phoenix supports emoji out-of-the 📦",
  user_id: user1.id})
Repo.insert!(%Message{content: "I am a block of granite.", user_id: user3.id})
