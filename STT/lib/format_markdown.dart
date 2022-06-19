import 'package:flutter/material.dart';

/// Use this class for converting String to [ResultMarkdown]
class FormatMarkdown {
  /// Convert [data] part into [ResultMarkdown] from [type].
  /// Use [fromIndex] and [toIndex] for converting part of [data]
  /// [titleSize] is used for markdown titles
  static ResultMarkdown convertToMarkdown(MarkdownType type, String data, int fromIndex, int toIndex,
      {int titleSize = 1}) {
    late String changedData;
    late int replaceCursorIndex;

    switch (type) {
      case MarkdownType.key_tag:
        changedData = '<key>${data.substring(fromIndex, toIndex)}</key>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.negative:
        changedData = '<부정>${data.substring(fromIndex, toIndex)}</부정>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.positive:
        changedData = '<긍정>${data.substring(fromIndex, toIndex)}</긍정>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_name:
        changedData = '<N>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_address:
        changedData = '<A>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_call:
        changedData = '<T>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_account:
        changedData = '<ACC>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_credit:
        changedData = '<S>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_register:
        changedData = '<RN>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_birth:
        changedData = '<R>';
        replaceCursorIndex = 1;
        break;
      case MarkdownType.customer_email:
        changedData = '<C>';
        replaceCursorIndex = 1;
        break;
    }

    final cursorIndex = changedData.length;

    return ResultMarkdown(data.substring(0, fromIndex) + changedData + data.substring(toIndex, data.length),
        cursorIndex, replaceCursorIndex);
  }
}

/// [ResultMarkdown] give you the converted [data] to markdown and the [cursorIndex]
class ResultMarkdown {
  /// String converted to mardown
  String data;

  /// cursor index just after the converted part in markdown
  int cursorIndex;

  /// index at which cursor need to be replaced if no text selected
  int replaceCursorIndex;

  /// Return [ResultMarkdown]
  ResultMarkdown(this.data, this.cursorIndex, this.replaceCursorIndex);
}

/// Represent markdown possible type to convert
enum MarkdownType {
  /// For **bold** text
  key_tag,

  /// For _italic_ text
  negative,

  /// For ~~strikethrough~~ text
  positive,

  /// For [link](https://flutter.dev)
  customer_name,

  /// For # Title or ## Title or ### Title
  customer_address,

  /// For :
  ///   * Item 1
  ///   * Item 2
  ///   * Item 3
  customer_call,

  /// For ```code``` text
  customer_account,

  /// For :
  ///   > Item 1
  ///   > Item 2
  ///   > Item 3
  customer_credit,

  /// For adding ------
  customer_register,

  /// For ![Alt text](link)
  customer_birth,

  customer_email,
}

/// Add data to [MarkdownType] enum
extension MarkownTypeExtension on MarkdownType {
  /// Get String used in widget's key
  String get key {
    switch (this) {
      case MarkdownType.key_tag:
        return 'bold_button';
      case MarkdownType.negative:
        return 'italic_button';
      case MarkdownType.positive:
        return 'strikethrough_button';
      case MarkdownType.customer_name:
        return 'link_button';
      case MarkdownType.customer_address:
        return 'H#_button';
      case MarkdownType.customer_call:
        return 'list_button';
      case MarkdownType.customer_account:
        return 'code_button';
      case MarkdownType.customer_credit:
        return 'quote_button';
      case MarkdownType.customer_register:
        return 'separator_button';
      case MarkdownType.customer_birth:
        return 'image_button';
      case MarkdownType.customer_email:
        return 'email_button';
    }
  }

  /// Get Icon String
  IconData get icon {
    switch (this) {
      case MarkdownType.key_tag:
        return Icons.vpn_key_rounded;
      case MarkdownType.negative:
        return Icons.sentiment_very_dissatisfied;
      case MarkdownType.positive:
        return Icons.sentiment_satisfied_alt;
      case MarkdownType.customer_name:
        return Icons.person_pin_rounded;
      case MarkdownType.customer_address:
        return Icons.map_outlined;
      case MarkdownType.customer_call:
        return Icons.contact_phone_outlined;
      case MarkdownType.customer_account:
        return Icons.account_balance_wallet_outlined;
      case MarkdownType.customer_credit:
        return Icons.credit_card;
      case MarkdownType.customer_register:
        return Icons.receipt_long;
      case MarkdownType.customer_birth:
        return Icons.verified_user;
      case MarkdownType.customer_email:
        return Icons.email_outlined;
    }
  }
}