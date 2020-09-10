import 'package:newsapp/data/article_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class News {

  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?country=in$category&apiKey=5e2269a0bd074749993d6c4a4254cde4";
    Response response = await get(url);
    Map data = jsonDecode(response.body);

    if (data['status'] == "ok"){
      data['articles'].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
          );

          news.add(articleModel);

        }

      });
    }
  }
}

