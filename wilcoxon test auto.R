# Carregar pacotes necessários
library(dplyr)
library(purrr)

# Criar o dataframe com os dados
data <- read.csv("C:/Users/Administrator/Desktop/Rogerio/boxplot.csv", header = TRUE, sep = ",")

# Função para executar o teste de Wilcoxon entre todas as condições de cada vírus
wilcoxon_test <- function(df) {
  # Obter combinações únicas de condições
  conditions <- unique(df$Condition)
  comparisons <- combn(conditions, 2, simplify = FALSE)
  
  # Executar o teste para cada combinação
  results <- map_dfr(comparisons, function(pair) {
    group1 <- df %>% filter(Condition == pair[1]) %>% pull(TPM)
    group2 <- df %>% filter(Condition == pair[2]) %>% pull(TPM)
    
    test <- wilcox.test(group1, group2, alternative = "two.sided", correct = TRUE)
    
    # Retornar os resultados em formato tabular
    tibble(
      Virus = unique(df$Virus),
      Condition1 = pair[1],
      Condition2 = pair[2],
      p_value = test$p.value
    )
  })
  
  return(results)
}

# Aplicar a função para cada vírus e combinar os resultados
results <- data %>%
  group_by(Virus) %>%
  group_split() %>%
  map_dfr(wilcoxon_test)

# Exibir os resultados
print(results)

# Salvar os resultados em um arquivo CSV
write.csv(results, "C:/Users/Administrator/Desktop/Rogerio/wilcoxon_results.csv", row.names = FALSE)
