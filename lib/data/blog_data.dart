import '../models/blog_post_modal.dart';

class BlogData {
  static List<BlogPost> getBlogPosts() {
    return [
      const BlogPost(
        title: 'Road Safety in Sri Lanka',
        subtitle: 'A Growing Concern',
        imageUrl: 'assets/images/blog1.png',
      ),
      const BlogPost(
        title: 'How to get around Sri Lanka',
        subtitle: 'Travellers Isle',
        imageUrl: 'assets/images/blog2.png',
      ),
      const BlogPost(
        title: 'Transport Development',
        subtitle: 'Ceylon, 1800-1947',
        imageUrl: 'assets/images/blog3.png',
      ),
    ];
  }
}
