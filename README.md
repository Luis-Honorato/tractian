# Tractian

## Documentação 

### Introdução

App desenvolvido como desafio técninco para a vaga de desenvolvedor mobile Flutter na Tractian!

### Descrição do Projeto

**Tractian** é um aplicativo móvel desenvolvido em Flutter com o objetivo de gerenciar e visualizar uma estrutura hierárquica de nós (TreeNodes), como locais e ativos (AssetNodes). O aplicativo permite que o usuário filtre, visualize e expanda a hierarquia de nós com base em parâmetros definidos, mantendo a estrutura original dos dados. Este projeto também foca na implementação de funcionalidades como busca recursiva, filtragem complexa e manipulação de estados utilizando o padrão BLoC (Business Logic Component).

### Funcionalidades
1. **Hierarquia de Nós (TreeNodes)**

    **TreeNode**: A estrutura básica de nós que pode conter outros nós filhos, formando uma árvore.
    **AssetNode**: Uma classe que estende TreeNode, representando ativos com atributos adicionais, como sensorType, status, e isComponent.
    **LocationNode**: Outra subclasse de TreeNode que representa um local físico na hierarquia.
    O aplicativo permite a navegação por essa estrutura, exibindo e expandindo os nós conforme o usuário interage.

2. **Filtros de Nós**

   **Filtragem por Nome**: Os usuários podem buscar nós pelo nome. O filtro é aplicado de forma recursiva, garantindo que toda a hierarquia seja verificada e mantida conforme o filtro é aplicado.
    **Filtragem por Atributos Específicos**:
        Filtro de **Status**: Filtro baseado no status do nó, sendo alert o critério principal.
        Filtro de **SensorType**: Filtragem dos nós com base no tipo de sensor, com foco em energy.

    Os filtros são combináveis e respeitam a hierarquia original dos nós, mantendo a estrutura intacta enquanto o conteúdo filtrado é exibido.

3. **Manipulação de Estados com BLoC**

    O gerenciamento de estados no aplicativo é feito com o uso do BLoC. Eventos e estados são utilizados para:
        **Carregar os nós:** Quando o aplicativo é iniciado, os nós são buscados a partir de uma fonte de dados remota e organizados em uma estrutura hierárquica.
        **Filtrar nós:** A filtragem é implementada dentro do evento FilterNodesEvent, que processa a query de busca e os filtros selecionados (status e sensorType).
        **Expandir/Contrair Nós:** A expansão dos nós é controlada por um Cubit, que gerencia o estado de abertura (isOpen) de cada nó.

4. **Busca Recursiva**

A lógica de busca recursiva garante que, ao aplicar filtros ou buscas, toda a árvore de nós seja percorrida, e nós relevantes sejam mantidos na exibição. Essa abordagem também permite manter a relação pai-filho intacta, mesmo quando apenas os filhos correspondem ao critério de busca.

5. **Interface do Usuário (UI)**

    **Botões de Filtro**: Há botões específicos na interface que permitem que o usuário aplique filtros de forma rápida, como "Sensor de Energia" e "Crítico".
    **Indicadores de Expansão:** A UI mostra um ícone para indicar se um nó pode ser expandido, facilitando a navegação entre os nós.
    **Indicadores de Alerta:** Ícones especiais são exibidos ao lado dos nós com status de alert.

### Como Usar

Após clonar o repositório localmente e abri-lo com sua IDE favorita, executar o seguinte commando no terminal:
```bash
flutter pub get
```
Este comando baixará todas as depêndencias externas utilizadas para o desenvolvimento do aplicativo. 

Executar o comando no terminal:
```bash
dart run build_runner watch
```
Isso irá instalar os mocks nescessários para rodar os testes do projeto.

Caso apareça algum conflito como a imagem abaixo:
![image](https://github.com/Luis-Honorato/fast_trivia/assets/90717674/f9b2ac46-08b5-46e6-9f40-6796ebafcf71)

Pressione a tecla 1

Ao finalizar a atualização e download dos mocks, ainda selecionando o terminal pressione as teclas ```CTR + C``` para finalizar a execução do comando acima.

Foram feitos no total 20 testes para garantir a usabilidade e funcionamento do aplicativo, eles podem ser encontrados na pasta ```/test``` e acompanham a arquitetura do projeto.
Para rodar todos os testes e verificar se o aplicativo encontra-se funcionando como o esperado rode o comando no terminal:
```bash
flutter test
```
Isso irá rodar todos os testes e entregar uma resposta visual se passaram ou quebraram.

### Escolha da arquitetura

Como arquitetura foi escolhida a Clean Architecture.

A Clean Architecture é um princípio de design que visa separar as responsabilidades e camadas de um aplicativo de maneira a promover a modularização, reutilização de código e facilidade de teste. Essa separação também permite melhor adaptabilidade a mudanças no futuro e reduz o risco de componentes fortemente acoplados.

#### Benefícios da Clean Architecture

1. Modularização e Separação de Camadas:
A Clean Architecture divide o aplicativo em camadas distintas, cada uma com uma responsabilidade específica. Essas camadas incluem a Camada de Presentation (Apresentação), a Camada de Domain (Domínio) e a Camada de Data (Dados). Essa separação promove a modularização do código, tornando mais fácil substituir ou modificar componentes individuais sem afetar outras partes do aplicativo. Essa modularização garante que os componentes da UI possam ser alterados sem modificar a lógica de negócios central, favorecendo a manutenção do código.

2. Testabilidade:
Uma das principais vantagens da Clean Architecture é seu impacto na testabilidade. A separação de responsabilidades possibilita testar cada camada de forma independente. A lógica de negócios pode ser testada sem a necessidade de componentes de interface do usuário ou dependências externas. Isso permite uma cobertura de teste abrangente, resultando em um aplicativo mais confiável.

3. Escalabilidade:
A Clean Architecture suporta a escalabilidade de aplicativos ao encapsular a funcionalidade em camadas distintas. À medida que o aplicativo cresce, novos recursos podem ser adicionados estendendo camadas existentes ou adicionando novas. Essa flexibilidade evita a introdução de código confuso e promove um código estruturado e organizado. 

5. Independência de Frameworks e Bibliotecas:
A Clean Architecture prioriza a independência da lógica de negócios central de frameworks e bibliotecas externas. Isso garante que a funcionalidade essencial do aplicativo não seja afetada por mudanças nas tendências tecnológicas ou atualizações no próprio Flutter.

### Considerações finais
Sou extremamente grato pela oportunidade de participar desse processo seletivo, acredito que tenho as capacidades técnicas para compor o time de mobile, também sou dedicado, esforçado, comunicativo e proativo.
Ficaria honradíssimo em receber um retorno positivo sobre este desafio técnico que fiz com tanto carinho e dedicação, estou disponível para qualquer conversa e melhoria.
Sei que preciso aprender mais coisas e melhorar em alguns aspectos, mas saiba que sempre estarei disposto a ouvir, aprender, correr atrás daquilo que não sei e de me comunicar caso fique preso com alguma dívida técnica.

Muito obrigado pela atenção. 

Abraços, Luis Honorato 💙
