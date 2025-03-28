# Passo 1: Carregar as bibliotecas necessárias
library(circlize)
library(readxl)

# Passo 2: Ler os dados do Excel
dados <- read_excel("/Users/Administrator/Desktop/celeste/transmission.xlsx")


# Passo 3: Criar a tabela de contingência para BioProject vs Library
contingencia_bio <- table(dados$Transmission, dados$Viruses)

# Passo 4: Converter a tabela de contingência em uma matriz
contingencia_bio_matrix <- as.matrix(contingencia_bio)

# Passo 5: Criar o Chord Diagram de BioProject vs Library
# Primeiro Chord Diagram - BioProject vs Library
chordDiagram(contingencia_bio_matrix, 
             transparency = 0.5,    # Define a transparência dos links
             annotationTrack = "grid",  # Adiciona uma grade
             preAllocateTracks = 1)  # Reserva espaço para o gráfico

# Adicionar os nomes na vertical para BioProject vs Library
circos.trackPlotRegion(track.index = 1, 
                       panel.fun = function(x, y) {
                         circos.text(CELL_META$xcenter, 
                                     CELL_META$ylim[1], 
                                     CELL_META$sector.index, 
                                     facing = "reverse.clockwise",  # Rótulos na vertical
                                     niceFacing = TRUE,
                                     adj = c(0.5, 1))  # Ajusta alinhamento
                       }, bg.border = NA)  # Remove bordas do fundo

# Passo 6: Criar o Chord Diagram para Library vs Virus
# Segundo Chord Diagram - Library vs Virus
contingencia_virus <- table(dados$Library, dados$Virus)
contingencia_virus_matrix <- as.matrix(contingencia_virus)

chordDiagram(contingencia_virus_matrix, 
             transparency = 0.5, 
             annotationTrack = "grid", 
             preAllocateTracks = 1)  # Reserva espaço para o gráfico

# Adicionar os nomes na vertical para Library vs Virus
circos.trackPlotRegion(track.index = 1, 
                       panel.fun = function(x, y) {
                         circos.text(CELL_META$xcenter, 
                                     CELL_META$ylim[1], 
                                     CELL_META$sector.index, 
                                     facing = "reverse.clockwise",  # Rótulos na vertical
                                     niceFacing = TRUE,
                                     adj = c(0.5, 1))
                       }, bg.border = NA)

# Passo 7: Criar o Chord Diagram para BioProject vs Material Genético
# Terceiro Chord Diagram - BioProject vs Material Genético
contingencia_material <- table(dados$Virus, dados$`Genetic Material`)
contingencia_material_matrix <- as.matrix(contingencia_material)

chordDiagram(contingencia_material_matrix, 
             transparency = 0.5, 
             annotationTrack = "grid", 
             preAllocateTracks = 1)  # Reserva espaço para o gráfico

# Adicionar os nomes na vertical para BioProject vs Material Genético
circos.trackPlotRegion(track.index = 1, 
                       panel.fun = function(x, y) {
                         circos.text(CELL_META$xcenter, 
                                     CELL_META$ylim[1], 
                                     CELL_META$sector.index, 
                                     facing = "reverse.clockwise",  # Rótulos na vertical
                                     niceFacing = TRUE,
                                     adj = c(0.5, 1))
                       }, bg.border = NA)
