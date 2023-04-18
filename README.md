<p align="center">
  <h2 align="center">Alpha Blog</h2>
</p>

<p align="center">
<img src="https://img.shields.io/badge/language-Rails_6-blue?style=for-the-badge">
</p>

<br>

## About application

Alpha Blog is a Ruby on Rails 6 application that provides a range of features to enhance the user experience. The application includes authentication and authorization functionality, which is implemented using the bcrypt and Devise gems, and ActiveAdmin for administration purposes. The major focus of the application is on the users, articles, and categories.

In addition to standard CRUD functionality, Alpha Blog includes several advanced features. Users can search for articles, users, and categories. Users can also follow other users and be followed by other users which will enable them to see content posted by followed users on their feed.

The real-time chat application, implemented using the Action Cable gem, allows users to chat with each other in real-time. This feature enhances the social aspect of the application and encourages user engagement.

Alpha Blog also includes a featured articles section, where the most popular and highly rated articles are displayed which is managed by the admin and subadmin. Users can also "clap" for articles they like, which encourages other users to read and engage with the content.

Overall, Alpha Blog is a comprehensive and user-friendly application that provides a range of features to enhance the user experience. The application includes advanced functionality such as real-time chat, search, and social features, as well as standard CRUD operations and administration capabilities. With its focus on articles, categories, and user engagement, Alpha Blog is a valuable resource for anyone looking to create, share, or discover quality content.

## Major Features
- Custom Authentication using bcrypt and admin authentication using devise
- Authorization using active admin gem
- Pagination using will_paginate gem
- Styling using bootstrap and scss
- Real-time chatroom using action cable
- Search functionality
- CRUD operation on users, articles, categories
- Sub admin feature for managing categories and featured articles.
- Clap Articles
- Following user functionality
- Gravatar for profile icon
- Applicaiton testing using rspec


## Technology used
- ruby v3.2.0
- rails v6.1.7
- bootstrap
- rspec


## Setup steps
Follow the below guidelines: 

**1.**  Fork [this](https://github.com/Chaitanya31612/alpha-blog-ror) repository.

**2.**  Clone your forked copy of the project or directly.


**3.** Navigate to the project directory :file_folder: .

```
cd alpha-blog-ror
```

**4.** Start postgresql server if it's not online.
```
sudo service postgresql start
```

**5.** Check postgresql status
```
sudo service postgresql status
```

**5.** Run db migrations and seed
```
rails db:setup
```

**6.** Start rails server
```
rails server or rails s
```

<br>

## Video Demo

https://user-images.githubusercontent.com/54992097/232709506-27babc60-916d-40a5-b820-2525ae1f3601.mp4

### Credits
This project is made by taking reference from :- [The Complete Ruby on Rails Developer Course](https://www.udemy.com/course/the-complete-ruby-on-rails-developer-course/learn/lecture/3862422?start=360#overview)
