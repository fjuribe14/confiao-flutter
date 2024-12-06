// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_message.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetPushMessageCollection on Isar {
  IsarCollection<int, PushMessage> get pushMessages => this.collection();
}

const PushMessageSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'PushMessage',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'messageId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'title',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'body',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sentDate',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'data',
        type: IsarType.json,
      ),
      IsarPropertySchema(
        name: 'imageUrl',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'status',
        type: IsarType.bool,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, PushMessage>(
    serialize: serializePushMessage,
    deserialize: deserializePushMessage,
    deserializeProperty: deserializePushMessageProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializePushMessage(IsarWriter writer, PushMessage object) {
  IsarCore.writeString(writer, 1, object.messageId);
  IsarCore.writeString(writer, 2, object.title);
  IsarCore.writeString(writer, 3, object.body);
  IsarCore.writeLong(writer, 4, object.sentDate.toUtc().microsecondsSinceEpoch);
  IsarCore.writeString(writer, 5, isarJsonEncode(object.data));
  {
    final value = object.imageUrl;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.status;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeBool(writer, 7, value);
    }
  }
  return object.id;
}

@isarProtected
PushMessage deserializePushMessage(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _messageId;
  _messageId = IsarCore.readString(reader, 1) ?? '';
  final String _title;
  _title = IsarCore.readString(reader, 2) ?? '';
  final String _body;
  _body = IsarCore.readString(reader, 3) ?? '';
  final DateTime _sentDate;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _sentDate = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _sentDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final dynamic _data;
  _data = isarJsonDecode(IsarCore.readString(reader, 5) ?? 'null') ?? null;
  final String? _imageUrl;
  _imageUrl = IsarCore.readString(reader, 6);
  final bool? _status;
  {
    if (IsarCore.readNull(reader, 7)) {
      _status = null;
    } else {
      _status = IsarCore.readBool(reader, 7);
    }
  }
  final object = PushMessage(
    id: _id,
    messageId: _messageId,
    title: _title,
    body: _body,
    sentDate: _sentDate,
    data: _data,
    imageUrl: _imageUrl,
    status: _status,
  );
  return object;
}

@isarProtected
dynamic deserializePushMessageProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 5:
      return isarJsonDecode(IsarCore.readString(reader, 5) ?? 'null') ?? null;
    case 6:
      return IsarCore.readString(reader, 6);
    case 7:
      {
        if (IsarCore.readNull(reader, 7)) {
          return null;
        } else {
          return IsarCore.readBool(reader, 7);
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _PushMessageUpdate {
  bool call({
    required int id,
    String? messageId,
    String? title,
    String? body,
    DateTime? sentDate,
    String? imageUrl,
    bool? status,
  });
}

class _PushMessageUpdateImpl implements _PushMessageUpdate {
  const _PushMessageUpdateImpl(this.collection);

  final IsarCollection<int, PushMessage> collection;

  @override
  bool call({
    required int id,
    Object? messageId = ignore,
    Object? title = ignore,
    Object? body = ignore,
    Object? sentDate = ignore,
    Object? imageUrl = ignore,
    Object? status = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (messageId != ignore) 1: messageId as String?,
          if (title != ignore) 2: title as String?,
          if (body != ignore) 3: body as String?,
          if (sentDate != ignore) 4: sentDate as DateTime?,
          if (imageUrl != ignore) 6: imageUrl as String?,
          if (status != ignore) 7: status as bool?,
        }) >
        0;
  }
}

sealed class _PushMessageUpdateAll {
  int call({
    required List<int> id,
    String? messageId,
    String? title,
    String? body,
    DateTime? sentDate,
    String? imageUrl,
    bool? status,
  });
}

class _PushMessageUpdateAllImpl implements _PushMessageUpdateAll {
  const _PushMessageUpdateAllImpl(this.collection);

  final IsarCollection<int, PushMessage> collection;

  @override
  int call({
    required List<int> id,
    Object? messageId = ignore,
    Object? title = ignore,
    Object? body = ignore,
    Object? sentDate = ignore,
    Object? imageUrl = ignore,
    Object? status = ignore,
  }) {
    return collection.updateProperties(id, {
      if (messageId != ignore) 1: messageId as String?,
      if (title != ignore) 2: title as String?,
      if (body != ignore) 3: body as String?,
      if (sentDate != ignore) 4: sentDate as DateTime?,
      if (imageUrl != ignore) 6: imageUrl as String?,
      if (status != ignore) 7: status as bool?,
    });
  }
}

extension PushMessageUpdate on IsarCollection<int, PushMessage> {
  _PushMessageUpdate get update => _PushMessageUpdateImpl(this);

  _PushMessageUpdateAll get updateAll => _PushMessageUpdateAllImpl(this);
}

sealed class _PushMessageQueryUpdate {
  int call({
    String? messageId,
    String? title,
    String? body,
    DateTime? sentDate,
    String? imageUrl,
    bool? status,
  });
}

class _PushMessageQueryUpdateImpl implements _PushMessageQueryUpdate {
  const _PushMessageQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<PushMessage> query;
  final int? limit;

  @override
  int call({
    Object? messageId = ignore,
    Object? title = ignore,
    Object? body = ignore,
    Object? sentDate = ignore,
    Object? imageUrl = ignore,
    Object? status = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (messageId != ignore) 1: messageId as String?,
      if (title != ignore) 2: title as String?,
      if (body != ignore) 3: body as String?,
      if (sentDate != ignore) 4: sentDate as DateTime?,
      if (imageUrl != ignore) 6: imageUrl as String?,
      if (status != ignore) 7: status as bool?,
    });
  }
}

extension PushMessageQueryUpdate on IsarQuery<PushMessage> {
  _PushMessageQueryUpdate get updateFirst =>
      _PushMessageQueryUpdateImpl(this, limit: 1);

  _PushMessageQueryUpdate get updateAll => _PushMessageQueryUpdateImpl(this);
}

class _PushMessageQueryBuilderUpdateImpl implements _PushMessageQueryUpdate {
  const _PushMessageQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<PushMessage, PushMessage, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? messageId = ignore,
    Object? title = ignore,
    Object? body = ignore,
    Object? sentDate = ignore,
    Object? imageUrl = ignore,
    Object? status = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (messageId != ignore) 1: messageId as String?,
        if (title != ignore) 2: title as String?,
        if (body != ignore) 3: body as String?,
        if (sentDate != ignore) 4: sentDate as DateTime?,
        if (imageUrl != ignore) 6: imageUrl as String?,
        if (status != ignore) 7: status as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension PushMessageQueryBuilderUpdate
    on QueryBuilder<PushMessage, PushMessage, QOperations> {
  _PushMessageQueryUpdate get updateFirst =>
      _PushMessageQueryBuilderUpdateImpl(this, limit: 1);

  _PushMessageQueryUpdate get updateAll =>
      _PushMessageQueryBuilderUpdateImpl(this);
}

extension PushMessageQueryFilter
    on QueryBuilder<PushMessage, PushMessage, QFilterCondition> {
  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      titleGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      titleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      bodyGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      bodyLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> bodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      bodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> sentDateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      sentDateGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      sentDateGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      sentDateLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      sentDateLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> sentDateBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> imageUrlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterFilterCondition> statusEqualTo(
    bool? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }
}

extension PushMessageQueryObject
    on QueryBuilder<PushMessage, PushMessage, QFilterCondition> {}

extension PushMessageQuerySortBy
    on QueryBuilder<PushMessage, PushMessage, QSortBy> {
  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByMessageIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByBody(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByBodyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortBySentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortBySentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByImageUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }
}

extension PushMessageQuerySortThenBy
    on QueryBuilder<PushMessage, PushMessage, QSortThenBy> {
  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByMessageIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByBody(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByBodyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenBySentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenBySentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByImageUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }
}

extension PushMessageQueryWhereDistinct
    on QueryBuilder<PushMessage, PushMessage, QDistinct> {
  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByBody(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctBySentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PushMessage, PushMessage, QAfterDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }
}

extension PushMessageQueryProperty1
    on QueryBuilder<PushMessage, PushMessage, QProperty> {
  QueryBuilder<PushMessage, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<PushMessage, String, QAfterProperty> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<PushMessage, String, QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<PushMessage, String, QAfterProperty> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<PushMessage, DateTime, QAfterProperty> sentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<PushMessage, dynamic, QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<PushMessage, String?, QAfterProperty> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<PushMessage, bool?, QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension PushMessageQueryProperty2<R>
    on QueryBuilder<PushMessage, R, QAfterProperty> {
  QueryBuilder<PushMessage, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<PushMessage, (R, String), QAfterProperty> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<PushMessage, (R, String), QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<PushMessage, (R, String), QAfterProperty> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<PushMessage, (R, DateTime), QAfterProperty> sentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<PushMessage, (R, dynamic), QAfterProperty> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<PushMessage, (R, String?), QAfterProperty> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<PushMessage, (R, bool?), QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension PushMessageQueryProperty3<R1, R2>
    on QueryBuilder<PushMessage, (R1, R2), QAfterProperty> {
  QueryBuilder<PushMessage, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, String), QOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, String), QOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, String), QOperations> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, DateTime), QOperations>
      sentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, dynamic), QOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, String?), QOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<PushMessage, (R1, R2, bool?), QOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
