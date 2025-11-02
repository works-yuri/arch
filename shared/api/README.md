
## Exemple

```Dart
final client = SharedApiClient(
    session: HttpOnSession<TokenState>(
        onClear: () async { },
        onRead: () async { },
        onUpdate: (TokenState token) async {},
    ),
    credentials: SharedApiCredentials(
        host: 'host.com',
        clientID: '',
        clientSecret: '',
    ),
);

final request = SignInWithUsernameAndPassword(
    password: 'password',
    username: 'username',
);

final response = await client.execute<SingInResponse>(request);

final profile = await client.execute<ProfileResponse>(ReadProfile());

```

## Tree

```bash
lib
    - src
        - client
        - common
        - requests
        - responses
    - shared_api.dart
```