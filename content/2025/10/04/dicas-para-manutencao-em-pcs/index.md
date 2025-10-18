---
title: Dicas para manutenção em PCs
date: 2025-10-04T20:28:00-03:00
slug: dicas-para-manutencao-em-pcs
comments: true
tags:
- technology
- career
- troubleshooting 
- helpdesk
- do-it-yourself
- personal-computers
draft: false
---

Iai, blz? Então, hoje eu pensei em vir aqui compartilhar alguns conhecimentos que adquiri durante o início da minha carreira onde era técnico em informática e trabalhava como *suporte* ou conhecido hoje como *helpdesk*. Vou tentar se claro e objetivo nas informações para que a leitura não fique tão massante.

## Ferramentas
Se você um dia pretende prestar esse tipo de serviço ou pelo menos por hobbie, tenha em mente que ter boas ferramentas ajuda bastante a dar manutenção não somente em PCs mas também em outros equipamentos eletrônicos que você tem em casa, como um purificador, ar condicionado, etc. Caso queira se aprofundar mais, recomendo pelo menos ter uma noção básica de eletrônica e assim seu leque expande vertiginosamente.
Sobre as ferramentas as melhores que você pode ter são os kits da IFIXIT, o [Pro Tech Go Toolkit](https://www.ifixit.com/products/pro-tech-go-toolkit) custa **$49,95**. É excelente para dar manutenção em qualquer eletrônico que você tenha em casa, até em smartphones mas não recomendo fazer isso pois a chance de você amandor estragar alguma coisa é muito alta, então **não faça isso**.

Ah sim, eu sei que esse que citei é bem caro mas vale bastante a pena, tenho um conjunto desse a mais de 6 anos e está intacto até o momento. Caso não possa, pode iniciar com algum kit básico do Aliexpress como [esse](https://pt.aliexpress.com/item/1005006853537175.html?spm=a2g0o.productlist.main.4.db57KWlpKWlpqw&aem_p4p_detail=2025100416485739893299647320010581688&algo_pvid=fd78d747-d604-4566-ba51-d8f46661baa7&algo_exp_id=fd78d747-d604-4566-ba51-d8f46661baa7-3&pdp_ext_f=%7B%22order%22%3A%22534%22%2C%22eval%22%3A%221%22%2C%22fromPage%22%3A%22search%22%7D&pdp_npi=6%40dis%21BRL%2159.77%2146.50%21%21%2110.36%218.06%21%402101c5b217596217376577730e4a16%2112000039268898740%21sea%21BR%210%21ABX%211%210%21n_tag%3A-29910%3Bd%3Ab26f3f05%3Bm03_new_user%3A-29895%3BpisId%3A5000000183957773&curPageLogUid=rrigPk5fhiXA&utparam-url=scene%3Asearch%7Cquery_from%3A%7Cx_object_id%3A1005006853537175%7C_p_origin_prod%3A&search_p4p_id=2025100416485739893299647320010581688_1) já vai te ajudar bastante.

Há claro, ter um multímetro ajuda bastante a identificar problemas simples então não pode faltar também, pode comprar algum com boas avaliações que já serve.

Outra coisa que não pode faltar para você e ter uma boa pasta térmica (não gosto de ficar abrindo PC todo mês 😅) e uma boa garante pelo menos um ano de durabilidade sem precisar de troca. A [Cryofuse](https://www.kabum.com.br/produto/375076) da Cooler Master atende muito bem a maioria das necessidades, agora se o seu caso é de um PC high-end talvez seja bom pensar em uma da Thermal Grizzly ou metal líquido, mas ai é coisa de quem sabe o que está fazendo.

Por último, não esqueça de ter um bom conjunto de pinceis para limpar poeira, ajuda bastante. Esse conjunto [aqui](https://www.amazon.com.br/dp/B0DN4RRP9Q?ref=ppx_yo2ov_dt_b_fed_asin_title) na Amazon é muito bom!

## Evite Problemas
Um dos erros mais comuns de pessoas que montam computadores é o calculo de energia necessária para a escolha correta da fonte, hoje em dia é mais simples resolver isso pois existem sites que já facilitam para você, como por exemplo esse da [MSI](https://br.msi.com/power-supply-calculator). Há junto disso **nunca compre fontes genéricas**, tem sérios riscos de danificar a sua placa-mãe, HD e os demais componentes com essa má ideia.

O outro é de montar um puta máquina parruda em um gabinete péssimo para "baratear" o custo, erro rude. Gabinetes de baixa qualidade tendem a ocasionar problemas de curto, estática, superaquecimento e demais relacionados então eu recomendo **nunca comprar um gabinete genérico**, esse é um componente que pode ser reutilizado na atualização do seu equipamento, então não vacile com isso pois pode dar uma dor de cabeça desnecessária no futuro.

Uma outra dica valiosa é escolha **Air Cooler** antes de um **Water Cooler**, a manutenção é muito mais simplificada e o desempenho em geral é similar. Water Cooler só é interessante em máquinas high-end, com processadores que esquentam bastante e provavelmente não é caso da maioria das pessoas.

A última nesse tópico que vale mencionar é que vale considerar ter um HD mecânico para guardar seus dados pessoais, o custo é muito menor. SSD de fato foi uma baita revolução na industria mas o custo subiu bastante depois da pandemia de COVID-19, então não vejo como necessário guardar suas fotos e documentos em um disco caríssimo,  um HD é suficiente para essa finalidade.

## Softwares Obrigatórios
Antigamente eu usava bastante o famoso [Hiren's Boot](https://www.hirensbootcd.org), um sistema com um conjunto de softwares completo, quase como um canivete. Mas também tem uma excelente opção russa que é o [Sergei Strelec](https://sergeistrelec.ru/winpe-10-8-sergei-strelec-english/214-winpe-10-8-sergei-strelec-x86-x64-native-x86-20220103-english-version.html) um conjunto completíssimo com alguns dos melhores softwares do mercado (inclusive os pagos 🏴‍☠️). Ou seja, com um pendrive com mais de 8GB você consegue configurar máquinas, recuperar arquivos deletados, particionar discos, checar saúde de alguns componentes, recuperar discos de forma lógica (bad blocks) entre demais inúmeras outras coisas.

Ah se você é um usuário avançado, um pendrive com qualquer linux já resolve a maioria dos problemas e de forma mais segura se é que me entende. ✌🏻😉

## Troubleshooting
Agora vamos a resoluções de problemas em computadores mais comuns e como resolve-los.

#### PC não liga
- Checar primeiramente fonte de alimentação, se quiser pode usar um mustímetro e validar as tensões de cada cabo para ter certeza.
- Se o passo anterior foi vencido, daqui para frente manuseie o computador com a fonte de alimentação fora da tomada para evitar estática e penas ligue para testar.
- Caso tenha placa de vídeo, valide se a saída de vídeo na BIOS está correta, se não for o caso pode ser algo relacionado ao vídeo integrado ou chipset da placa-mãe.
- Valide se as memórias estão encaixadas corretamente nos slots e se tiver alguma configuração customizada de clock, recomendo deixa a padrão para evitar problemas e as vezes, só trocar as memórias de lugar resolve pois acumula sujeira nos encaixes metálicos.
- Se nenhum dessas dicas funcionaram, o problem pode ser mais sério então comece apagando a BIOS, pode ser retirando a bateria ou usando os jumpers que realizam esse reset de fábrica. Outro ajuste que vale dar uma olhada é se existe alguma correção de BIOS séria para a sua placa-mãe, apenas atualizar pode resolver.
- Novamente se não funcionou, agora eliminamos boa parte dos componentes então sobrou apenas placa-mãe e processador. Nesse caso é um problema maior porque testar daqui para frente fica bem mais complicado, mas você pode olhar toda a placa-mãe para ver se encontra algo queimado (capacitor), trilha riscada, chipset esquentando, algum ponto que de curto com o gabinete (pode ser os parafusos que prendem a placa no gabinete), por último ligar o computador sem o coller no processador e validar se a temperatura sobe (pode ser com o dedo mesmo, mas o melhor é usar o multímetro) e caso não mude, você deu um puta azar do processador queimar ou dar curto.

#### PC não se mantém funcionando por muito tempo
- Primeiramente, valide a fonte de alimentação novamente pois pode ser simplesmente falta de energia em componentes como um HD e que pode ocasionar inúmeros problema difíceis de identificar.
- Checar se a refrigeração do coller está funcional, o problema pode ser superaquecimento de CPU e o próprio desliga a máquina ou baixa o clock para não queimar (uma medida de segurança padrão).
- Se o computador antes de travar apresenta as famosas "blue screen of death" algo no seu hardware provavelmente não está funcionando como deveria e em grande maioria pode ser o seu HD velho de guerra então valide se não existem badblocks, outro bom teste é escutar ele em funcionamento e se está fazendo muito barulho, caso sim provavelmente você achou o problema (vale lembrar que o seu disco de dados não provoca esses problemas, apenas onde o sistema operacional está instalado).
- O chipset da placa-mãe também pode estar esquentando bastante e ocasionando mal funcionamento de alguns componentes, principalmente o de vídeo integrado. Trocar os "thermal pads" já pode ajudar bastante.
- Agora se nenhum desses pontos resolveram, apenas formate o seu computador com uma nova instalação limpa de sistema que pode resolver.

## Considerações Finais
Antigamente eu conseguia ganhar até um bom dinheiro com manutenção de computadores na minha própria casa e indo fazer o trabalho na cas do cliente, tanto que consegui comprar um PS3 usado em 2011 (para alguém pobre que nem eu foi um marco 😆) já hoje em dia não vejo que esse cenário esteja no mesmo patamar então recomendo você prestar serviço para alguma empresa.

Cursos técnicos são muito bons para você poder ter uma formação e inciar no mercado de trabalho com alguma experiência prática, eu mesmo me formei na Escola Técnica de Brasília a muito tempo atrás e foi a melhor opção que fiz na minha vida, pois a partir do meu primeiro emprego que consegui pagar as parcelas da universidade, então se qualifique sempre que puder.

Uma dica final interessante é aprender eletrônica básica, com essa base você vai conseguir resolver problemas de forma mais lógica pois vai saber como componentes funcionam no geral, e isso fez uma diferença absurda nos meus primeiros empregos porque eu me destacava bastante dos demais.

Em geral é isso, espero ter ajudado de alguma forma. 