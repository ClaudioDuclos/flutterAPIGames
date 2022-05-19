# freegames

Projeto acadêmico de Flutter.

## Notas Iniciais

Acompanhe nosso projeto acadêmico utilizando Flutter. O conceito inicial do aplicativo é organizar através de listagens e filtros jogos gratuitos. A disponibilidade destes dados é derivada de uma API com sua chave de autenticação. Seu escopo inicial estrutura apenas uma ListView simples com as informações de Título, Gênero e Imagem. Possibilitando também o acesso à página própria do jogo (através do comando OnTap).

Em seu primeiro modelo, as informações estão organizadas na main.dart principal, sendo possivelmente separada em diferentes páginas em breve para melhor controle do projeto.

*OBS: O carregamento das imagens é um problema derivado da forma de renderização utilizada pelo Flutter nativo. Neste caso, executando através da plataforma Chrome é possível utilizando um renderer em html para visualização dessas imagens. Entretanto, atualmente em APK (Android), sua visualização é funcional.
