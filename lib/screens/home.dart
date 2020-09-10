import 'package:flutter/material.dart';
import 'package:newsapp/data/article_model.dart';
import 'package:newsapp/screens/article.dart';
import 'package:newsapp/services/news.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {

  final String category;
  Home({this.category});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 2;
  bool _loading = true;
  static String categoryName = '';

  List<ArticleModel> articles = new List<ArticleModel>();

  static List<String> categoryTypes = <String>[
    categoryName = '&category=technology',
    categoryName = '&category=health',
    categoryName = '',
    categoryName = '&category=business',
    categoryName = '&category=sports',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async{
    News news = News();
    await news.getNews(categoryTypes.elementAt(_selectedIndex));
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Daily',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 35.0,
              ),
            ),
            Text(
              'NEWS',
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 35.0,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),


      body: _loading ?
        Center(
          child: Container(
            child: SpinKitFoldingCube(
              color: Colors.amber,
              size: 60.0,
            ),
          ),
        ):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return NewsTile(
                      imgUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        elevation: 2.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            title: Text('Tech'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text('Health'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text('sports'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.amber,
        showUnselectedLabels: true,
      ),
    );
  }
}



class NewsTile extends StatelessWidget {

  final String imgUrl, title, desc, url;
  NewsTile({@required this.imgUrl, @required this.title, @required this.desc,
    @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Article(
              url: url,
            ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imgUrl,),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8,),
            Text(
              desc,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

