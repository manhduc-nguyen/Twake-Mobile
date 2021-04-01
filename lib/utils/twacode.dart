class TwacodeParser {
  final String original;
  static final RegExp userMatch = RegExp('@([a-zA-z0-9_]+):([a-zA-z0-9-]+)');

  List<ASTNode> nodes = [];

  TwacodeParser(this.original) {
    parse();
  }

  List<dynamic> get message => nodes.map((n) => n.transform()).toList();

  void parse() {
    int start = 0;
    for (int i = 0; i < original.length - 1; i++) {
      if (original[i] == Delim.star && original[i + 1] == Delim.star) {
        final index = this.doesCloseBold(i + 2);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
              type: TType.Bold, text: original.substring(i + 2, index - 2)));
          i = start = index;
        }
      } else if (original[i] == Delim.underline &&
          original[i + 1] == Delim.underline) {
        final index = doesCloseUnderline(i + 2);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.Underline,
                text: original.substring(i + 2, index - 2),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.underline &&
          original[i + 1] != Delim.underline) {
        final index = doesCloseItalic(i + 1);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.Italic,
                text: original.substring(i + 1, index - 1),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.tilde && original[i + 1] == Delim.tilde) {
        final index = doesCloseStrikeThrough(i + 2);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.StrikeThrough,
                text: original.substring(i + 2, index - 2),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.lf) {
        this.nodes.add(
              ASTNode(type: TType.Text, text: original.substring(start, i)),
            );
        this.nodes.add(ASTNode(
              type: TType.LineBreak,
              text: "",
            ));
        start = i + 1;
      } else if (original[i] == Delim.gt) {
        if (nodes.isEmpty || nodes.last.type == TType.LineBreak) {
          int index = this.hasLineFeed(i + 1);
          index = index != 0 ? index : original.length + 1;
          this.nodes.add(ASTNode(
                type: TType.Quote,
                text: original.substring(i + 1, index - 1),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.at &&
          (i == 0 || original[i - 1] == Delim.ws)) {
        final index = this.isUser(i + 1);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.User,
                text: original.substring(i + 1, index - 1),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.tick && original[i + 1] != Delim.tick) {
        final index = this.doesCloseInlineCode(i + 1);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.InlineCode,
                text: original.substring(i + 1, index - 1),
              ));
          i = start = index;
        }
      } else if (original[i] == Delim.tick &&
          original[i + 1] == Delim.tick &&
          i + 2 < original.length &&
          original[i + 2] == Delim.tick) {
        final index = this.doesCloseMultiCode(i + 3);
        if (index != 0) {
          this.nodes.add(
                ASTNode(type: TType.Text, text: original.substring(start, i)),
              );
          this.nodes.add(ASTNode(
                type: TType.MultiLineCode,
                text: original.substring(i + 3, index - 3),
              ));
          i = start = index;
        }
      }
    }
    this.nodes.add(ASTNode(
          type: TType.Text,
          text: original.substring(start),
        ));
    if (this.nodes.first.text.isEmpty) {
      this.nodes.removeAt(0);
    }
    if (this.nodes.last.text.isEmpty) {
      this.nodes.removeLast();
    }
  }

  int doesCloseBold(int i) {
    final len = original.length - 1;
    for (int j = i; j < len && original[j] != '\n'; j++) {
      if (original[j] == Delim.star && original[j + 1] == Delim.star) {
        return j + 2;
      }
    }
    return 0;
  }

  int doesCloseItalic(int i) {
    final len = original.length;
    for (int j = i; j < len && original[j] != '\n'; j++) {
      if (original[j] == Delim.underline) {
        return j + 1;
      }
    }
    return 0;
  }

  int doesCloseUnderline(int i) {
    final len = original.length - 1;
    for (int j = i; j < len && original[j] != '\n'; j++) {
      if (original[j] == Delim.underline &&
          original[j + 1] == Delim.underline) {
        return j + 2;
      }
    }
    return 0;
  }

  int isUser(int i) {
    for (int j = i; j < original.length; j++) {
      if (original[j] == Delim.ws || original[j] == Delim.lf) {
        if (userMatch.hasMatch(original.substring(i, j))) {
          return j;
        } else {
          return 0;
        }
      }
    }
    if (userMatch.hasMatch(original.substring(i))) {
      return original.length;
    } else {
      return 0;
    }
  }

  int doesCloseStrikeThrough(int i) {
    final len = original.length - 1;
    for (int j = i; j < len && original[j] != '\n'; j++) {
      if (original[j] == Delim.tilde && original[j + 1] == Delim.tilde) {
        return j + 2;
      }
    }
    return 0;
  }

  int doesCloseInlineCode(int i) {
    final len = original.length;
    for (int j = i; j < len && original[j] != '\n'; j++) {
      if (original[j] == Delim.tick) {
        return j + 1;
      }
    }
    return 0;
  }

  int doesCloseMultiCode(int i) {
    final len = original.length;
    int ticks = 0;
    for (int j = i; j < len; j++) {
      if (original[j] == Delim.tick) {
        if (ticks == 2) {
          return j + 1;
        } else {
          ticks += 1;
        }
      } else {
        ticks = 0;
      }
    }
    return 0;
  }

  int hasLineFeed(int i) {
    final len = original.length;
    for (int j = i; j < len; j++) {
      if (original[j] == Delim.lf) {
        return j + 1;
      }
    }
    return 0;
  }
}

class ASTNode {
  TType type;
  String text;
  ASTNode({this.type, this.text});

  dynamic transform() {
    Map<String, dynamic> map = {};
    switch (this.type) {
      case TType.Text:
        return this.text;

      case TType.LineBreak:
        map['start'] = '';
        map['end'] = '\n';
        map['content'] = [];
        break;

      case TType.InlineCode:
        map['start'] = '`';
        map['end'] = '`';
        map['content'] = this.text;
        break;

      case TType.MultiLineCode:
        map['start'] = '```';
        map['end'] = '```';
        map['content'] = this.text;
        break;

      case TType.Underline:
        map['start'] = '__';
        map['end'] = '__';
        map['content'] = this.text;
        break;

      case TType.StrikeThrough:
        map['start'] = '~~';
        map['end'] = '~~';
        map['content'] = this.text;
        break;

      case TType.Bold:
        map['start'] = '**';
        map['end'] = '**';
        map['content'] = this.text;
        break;

      case TType.Italic:
        map['start'] = '_';
        map['end'] = '_';
        map['content'] = this.text;
        break;

      case TType.Quote:
        map['start'] = '>';
        map['content'] = this.text;
        break;

      case TType.User:
        map['start'] = '@';
        map['content'] = this.text;
        break;

      case TType.Channel:
        map['start'] = '#';
        map['content'] = this.text;
        break;

      case TType.Url:
        map['type'] = 'url';
        map['content'] = this.text;
        break;

      case TType.Email:
        map['type'] = 'email';
        map['content'] = this.text;
        break;

      default:
        throw Exception('Unsupported twacode type');
    }
    return map;
  }
}

enum TType {
  Root,
  Text,
  LineBreak,
  InlineCode,
  MultiLineCode,
  Underline,
  StrikeThrough,
  Bold,
  Italic,
  Quote,
  User,
  Channel,
  Url,
  Email
}

class Delim {
  static String star = '*';
  static String underline = '_';
  static String tilde = '~';
  static String gt = '>';
  static String tick = '`';
  static String at = '@';
  static String lf = '\n';
  static String ws = ' ';
}