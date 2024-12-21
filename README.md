# **Projeto Panorama mundial da Covid-19**

### Resumo

Esse projeto analisou dados globais de Covid-19 entre os dias 01/01/2020 e 30/04/2021 com objetivo de traçar um panorama do impacto e progressão da doença no mundo, bem como os efeitos da testagem e vacinação.
Os produtos foram um relatório em Power BI contendo três dashboards com os principais insighst obtidos e um script SQL com a análise completa comentada. 

[Relatório - Panorama da Covid-19 no mundo](https://app.powerbi.com/view?r=eyJrIjoiZGQ0MzFmNTAtN2E5OS00NzQyLWJmMjktNzhjYjg1Y2Y2NzM0IiwidCI6ImUyZjc3ZDAwLTAxNjMtNGNmNi05MmIwLTQ4NGJhZmY5ZGY3ZCJ9).

Leia mais sobre o projeto abaixo.

### Índice

- [1. Contexto](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#1-contexto)
- [2.  Premissas assumidas para a análise](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#2--premissas-assumidas-para-a-an%C3%A1lise)
- [3. Ferramentas utilizadas](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#3-ferramentas-utilizadas)
- [4. Estratégias de solução](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#4-estrat%C3%A9gias-de-solu%C3%A7%C3%A3o)
- [5. O produto final do projeto](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#5-o-produto-final-do-projeto)
- [6. Principais insights de dados](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#6-principais-insights-de-dados)
- [7. Conclusão](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#7-conclus%C3%A3o)
- [8. Próximos passos](https://github.com/luisamuzzi/covid_project/tree/main?tab=readme-ov-file#8-pr%C3%B3ximos-passos)

### 1. Contexto

O objetivo desse projeto é analisar dados referentes à Covid-19 à nível de país e continente para se obter um panorama do comportamento da doença ao redor do mundo.

Os dados utilizados incluem a data, o país, o continente, o número de novos casos e de novas mortes, o número de hospitalizações e de internações em UTI, o número de vacinações, o índice de restrição, dados sociodemográficos, entre outros.

Assim, foram realizadas consultas SQL para extrair informações relevantes dos dados, permitindo mapear o comportamento da doença por país e por continente durante o período analisado.

Os principais insights obtidos foram inseridos em um relatório contendo três dashboards no Power BI, abordando os temas “Impacto e Progressão” e “Testagem e Vacinação”.

### 2.  Premissas assumidas para a análise

1. A análise foi realizada com dados entre 01/01/2020 e 30/04/2021
2. Os dados utilizados foram obtidos no P.E.D: https://renatabiaggi.com/ped/
3. A imagem utilizada no relatório do Power BI foi obtida em: https://storyset.com/illustration/coronavirus-second-wave/amico

### 3. Ferramentas utilizadas

- SQL
- Banco de dados SQLite
- DBeaver
- Power BI

### 4. Estratégias de solução

O projeto foi desenvolvido considerando-se cinco etapas gerais.

1. Criação do database e da tabela com os dados a serem analisados:

O banco de dados escolhido foi o SQLite devido a sua facilidade de uso, não requerendo configurações adicionais. 

Inicialmente criou-se uma pasta para armazenar os dados do projeto (Create → New Folder):

![create new folder](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(0).png)

Clicando-se em cima da pasta criada, criou-se uma conexão (Create → Connection). Em seguida foi escolhido o  SQLite e escolhida a opção Next.

![select sqlite database](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(1).png)

Configurou-se o caminho onde seria criado o arquivo do banco de dados (Path) e nomeou-se o banco de dados. Por fim, finalizou-se a configuração (Finish).

![database path](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(2).png)

Em seguida, verificou-se os arquivos csv que continham os dados, ou seja, se possuíam cabeçalho (nome das colunas), qual era o delimitador e se não havia erros no arquivo. O arquivo foi renomeado para o nome que seria usado na tabela no SQLite.

Então, criou-se um novo script para criação das queries SQL no qual foi criada a tabela.

![create table](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(3).png)

O próximo passo foi a importação dos arquivos csv para a tabela. Clicou-se na tabela criada e, em seguida, em Import Data. Com isso, o arquivo csv foi escolhido e configurado.

![import csv data](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(4).png)

1. Exploração dos dados por meio de consultas SQL:
    1. Análise exploratória dos dados para identificar a distribuição de features e padrões nos dados.
    2. Identificar dados faltantes e outliers.
2. Análise dos dados por meio de consultas SQL:
    
    Os dados foram analisados considerando-se três frentes:
    
    1. Análise do impacto e progressão da COVID-19
        - Total de casos e de mortes por país
        - Total de casos e de mortes por continente
        - Variação da taxa de mortalidade ao longo do tempo por país
        - Variação da taxa de mortalidade ao longo do tempo por continente
        - Probabilidade de morrer se contrair Covid em cada país
        - Probabilidade de morrer se contrair Covid em cada continente
        - Probabilidade de morrer se contrair Covid em cada país por mês
        - Probabilidade de morrer se contrair Covid em cada continente por mês
        - Probabilidade de se infectar com Covid por país
        - Probabilidade de se infectar com Covid por país por mês
        - Probabilidade de se infectar com Covid por continente
        - Cinco países com as maiores taxas de morte
        - Taxa de crescimento diário de novos casos e de novas mortes por país
        - Média de casos e mortes por milhão de habitantes por país
        - Pico de novos casos e novas mortes em cada país e em cada continente
        - Média móvel de novos casos e mortes nos últimos 7 dias por país
        - Maior número de casos e de mortes diárias até a data atual por país
        - Contribuição diária de cada país para o total de casos e de mortes de seu continente
        - Contribuição geral de cada país para o total de casos e de mortes de seu continente
        - empo em dias que cada país demorou para alcançar 50% de seus casos totais
        - Tempo em dias que cada país demorou para alcançar 50% de suas mortes totais
        - Variação da taxa de reprodução por país ao longo do tempo
        - Média de ocupação hospitalar e de UTI por país
        - Média de ocupação hospitalar e de UTI por milhão de habitantes por país
    2. Análise da Testagem e Vacinação
        - Porcentagem da população que recebeu pelo menos uma vacina contra Covid por país
        - Porcentagem da população que recebeu pelo menos uma vacina contra Covid por continente
        - Acumulado de vacina por país e por data
        - Comparativo de mortes e vacinações por mês por continente
        - Relação entre o número de testes realizados e a média da taxa de positividade ao longo dos meses
        - Maiores médias de vacinação por população por país
        - Média diária de novas vacinações por país
        - Relação entre o número de vacinações, internações hospitalares e na UTI ao longo do tempo por continente
        - Taxa de hospitalização e internação em UTI em relação ao número de casos por continente
    3. Análise dos impactos socioeconômicos e demográficos
        - Relação entre as políticas de restrição (stringency_index), novos casos e novas mortes
        - Índice de restrição média por continente comparado com o total de casos e mortes
        - Relação entre fatores demográficos/socioeconômicos e mortalidade por país
        - Relação entre fatores demográficos/socioeconômicos e mortalidade por continente
3. Integração com o Power BI para a criação de visualizações:
    
    Os dados das principais consultas foram importados para o Power BI e transformados em gráficos, cartões e tabelas, permitindo uma melhor visualização dos insights obtidos. 
    
    Para permitir a integração das consultas SQL realizadas com o Power BI foi utilizada uma conexão ODBC (Open Database Connectivity). No  caso do SQLite, é preciso fazer a instalação do driver no [link](http://www.ch-werner.de/sqliteodbc/).
    
    Em seguida, realizou-se o passo a passo: Get Data → More… → ODBC → Connect
    
    ![connect odbc](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(5).png)
    
    Na janela seguinte, selecionou-se SQLite3 Datasource e a opção Advanced Options. Neste menu, foi inserido o caminho do arquivo do banco de dados (database=<inserir caminho do arquivo no computador>) e a query cujos dados desejava-se importar.
    
    ![query](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(6).png)
    
    Na tela seguinte, clicou-se a conexão.
    
    ![connection](https://github.com/luisamuzzi/covid_project/blob/main/images/image%20(7).png)
    
4. Criação dos dashboards:
    
    Três dashboards foram criados para apresentação dos principais dados de maneira clara e acessível por meio de gráficos, cartões e tabelas:
    
    - Impacto e Progressão 1
    - Impacto e Progressão 2
    - Testagem e Vacinação

### 5. O produto final do projeto

Dashboards no Power BI com filtros de seleção (continente), botões de navegação entre a tela inicial, gráficos, tabelas e cartões.

O relatório pode ser visualizado por meio do link:

[Relatório - Panorama mundial da Covid-19](https://app.powerbi.com/view?r=eyJrIjoiZGQ0MzFmNTAtN2E5OS00NzQyLWJmMjktNzhjYjg1Y2Y2NzM0IiwidCI6ImUyZjc3ZDAwLTAxNjMtNGNmNi05MmIwLTQ4NGJhZmY5ZGY3ZCJ9).

1. Dashboard Impacto e Progressão 1:
    1. Cartões:
        1. Total de casos globais no período analisado
        2. Total de mortes globais no período analisado
        3. Total de hospitalizações no período analisado
        4. Total de internações em UTI no período analisado
        
        Do total de casos registrados, há uma porcentagem de aproximadamente 2,11% de mortes, 34,71% de internações hospitalares e 6,27% de internações em UTI.
        
    2. Gráficos:
        1. Percentual de mortes por mês por continente: O percentual de mortalidade passa por um pico seguido de queda em todos os continentes, com exceção da Oceania, no qual o comportamento
        possui uma queda seguida de aumento.
        2. Percentual de mortes em relação ao número de casos por continente: Os percentuais para os continentes são próximos, com exceção da Ásia. A princípio, a América do Sul apresenta o maior percentual, mas seria preciso um teste de hipóteses para verificar se há significância estatística nas diferenças entre os valores.
        3. Total de casos e mortes por continente: No total geral a Europa apresentou maior registro de mortes
        4. Percentual de hospitalizações e internações em UTI em relação ao número de casos: A Europa apresenta o maior percentual de hospitalizações e a América do Norte o maior percentual de internações em UTI. É importante destacar que dados relativos à hospitalização e à internação não foram disponibilizados para todos os países (não havia dados referentes aos países da África, Oceania e América do Sul).
2. Dashboard Impacto e Progressão 2:
    1. Gráficos:
        1. Comparativo do total de casos e índice de restrição médio: Não parece haver relação no período analisado.
        2. Top 5 países com maior taxa de infecção em relação à população: As taxas são próximas. A princípio, Andorra apresenta o maior valor, mas seria preciso um teste de hipóteses para verificar se há significância estatística nas diferenças entre os valores.
        3. Top 5 países com maior taxa de mortes em relação à população: As taxas são próximas. A princípio, Hungria apresenta o maior valor, mas seria preciso um teste de hipóteses para verificar se há significância estatística nas diferenças entre os valores.
    2. Tabela:
        1. Percentual de contribuição de cada país com o total de casos e mortes de seu continente: África: África do Sul (44.63%); Ásia: Índia (40.72%); Europa: Reino Unido (12.57%); América do Norte: Estados Unidos (67.96%); Oceania: Austrália (87%); América do Sul: Brasil (60.05%).
3. Dashboard Testagem e Vacinação:
    1. Gráficos:
        1. Comparativo da taxa de positividade média e do total de testes por mês: A princípio, não parece haver um padrão. A taxa de positividade média diminui ao longo do tempo, enquanto o total de testes oscila.
        2. Total de vacinações por mês por continente: permite o acompanhamento das vacinações.
        3. Comparativo do total do total de mortes e de vacinações por mês e por continente: Na Europa, África e América do Norte, o total de mortes parece diminuir com o aumento do total de vacinações.
        Na América do Sul e na Ásia, o número de mortes continua aumentando apesar do aumento de vacinações.

Além do relatório no Power BI, disponibilizou-se o script com os códigos em SQL contendo a análise completa e comentários dos insights obtidos.

### 6. Principais insights de dados

1.Apesar de a Europa possuir o maior número de casos e de mortes dentre os continentes, quando analisadas as mortes em relação aos casos, as maiores probabilidades de morte se dão na América do Sul e na África.
2. Os continentes possuem um comportamento semelhante em relação ao total de mortes ao longo do tempo, com exceção da Oceania;
3. A China foi o país que demorou mais tempo para atingir 50% de de suas mortes totais (433 dias) no período analisado. Como comparação, a Índia, país com maior contribuição para as mortes registradas na Ásia, demorou apenas 204 dias.
4. Diversos países tiveram um aumento no número de mortes ao longo dos meses, seguido de uma queda nos meses finais de análise. O que pode estar associado à vacinação, que se iniciou nos meses finais de análise. Essa observação não é tão clara no contexto de continentes.

### 7. Conclusão

O objetivo desse projeto foi analisar os dados de Covid-19 durante o período de 01/01/2020 a 30/04/2021 para obtenção de insights relevantes e criação de dashboards de acompanhamento do impacto da doença e vacinação a nível global. A análise permite a visualização e entendimento da situação, bem como a tomada de decisões a partir dos dados.

Além do panorama geral descrito anteriormente, outras fatores relevantes são:

- Algumas relações necessitam de mais dados para serem melhor avaliadas (por exemplo: vacinas x mortes, positividade x testes).
- É necessário a obtenção de dados de hospitalização em alguns continentes para análises mais completas dessa variável.
- Dados de países com infraestrutura mais precária podem não ter sido coletados em sua totalidade, ocasionando um viés nos dados.

### 8. Próximos passos

1. Realização de testes para verificação da significância estatística da diferença entre taxas e percentuais de casos e mortes entre continentes e países;
2. Verificação da relação entre as medidas de restrição adotadas em cada país e (i) tempo em que o país levou para atingir certo patamar de número de casos e mortes, (ii) total de casos e mortes;
3. Investigação mais detalhada para países específicos, por exemplo, aqueles que tiveram as maiores e as menores quantidades relativas de casos e mortes (observando-se se os números realmente foram menores ou se há apenas ausência de dados).
