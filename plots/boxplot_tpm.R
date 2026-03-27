# Carregar biblioteca necessária
library(ggplot2)

# Ler os dados do arquivo CSV
dados <- read.csv("C:/Users/Administrator/Desktop/Rogerio/boxplot.csv", header = TRUE)

# Aplicar a transformação logarítmica aos valores de TPM
dados$TPM <- log10(dados$TPM + 1)  # Adiciona 1 para evitar log de zero

# Criar o boxplot com pontos e painéis separados por vírus
ggplot(dados, aes(x = Condition, y = TPM, fill = Condition)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7) +  # Boxplot sem marcar outliers
  geom_jitter(width = 0.2, size = 2, color = "black") +  # Adicionar os pontos (jitter para evitar sobreposição)
  facet_wrap(~ Virus, scales = "free_y", ncol = 7) +  # Ajustar número de colunas conforme necessário
  theme_minimal() +
  labs(
    x = "Condição",
    y = "Log10(TPM)"
  ) +
  scale_fill_brewer(palette = "Set3") +
  theme(
    strip.background = element_rect(fill = "gray85", color = "black", size = 0.5),  # Fundo cinza e borda dos títulos dos painéis
    strip.text = element_text(size = 12, face = "bold"),  # Estilo do texto dos títulos
    panel.border = element_rect(color = "black", fill = NA, size = 0.01),  # Borda ao redor de cada painel
    axis.text.x = element_text(angle = 45, hjust = 1),   # Rotação do texto no eixo X
    panel.grid.minor = element_blank()                   # Remover grades menores
  )
