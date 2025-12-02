# StudyBuddy Studio

AI-drivet individualiserat lärande med interaktiva kunskapsgrafer för Chalmers-kurser. Ett komplett system för att bygga, analysera och studera genom kurser och koncept med AI-funktioner baserat på forskning inom Mastery Learning och Blooms 2-sigma problem.


## Projektstruktur och filer

```
chalmers-course-graph/
├── src/                        # Huvudkällkod för applikationen
│   ├── __init__.py            # Gör src till Python-modul
│   ├── streamlit_app.py       # Huvudapplikation med flik-navigering
│   ├── course_parser.py       # Parser för JSON-kursinformation
│   ├── llm_service.py         # AI/LLM-tjänst för konceptextraktion
│   └── graph_builder.py       # Bygger Neo4j-grafen från kurser
│
├── services/                   # Externa tjänster och databaskoppling
│   ├── __init__.py            # Gör services till Python-modul
│   ├── neo4j_service.py       # Neo4j databaskopplingar och queries
│   ├── graph_utils.py         # Hjälpfunktioner för grafanalys
│   └── memory_service.py      # Hantering av spaced repetition och memory curves
│
├── pages/                      # Streamlit-sidor (flikar)
│   ├── __init__.py            # Gör pages till Python-modul
│   ├── graph.py               # Graf-visualiseringssida med export
│   ├── analytics.py           # AI-analys och insikter
│   ├── study.py               # AI-stödd studievägledning med tre lärstilar
│   ├── progression.py         # Mastery scores och progression
│   ├── theory.py              # Pedagogisk bakgrund och forskning
│   ├── settings.py            # Systeminställningar och prompter
│   ├── repetition.py          # Spaced repetition för långsiktig memorering
│   ├── smart_training.py      # Automatiska AI-genererade studiesessioner
│   ├── canvas.py              # Canvas LMS-integration och synkronisering
│   ├── canvas_chat.py         # AI-chat med Canvas kursmaterial
│   ├── deadlines.py           # Översikt över assignments och deadlines
│   ├── alumn.py               # Karriärfunktioner för alumner
│   └── alumn_matching.py      # Matchning mot alumner, företag och studenter
│
├── components/                 # UI-komponenter
│   ├── __init__.py            # Gör components till Python-modul
│   └── network_vis.py         # PyVis nätverksvisualisering
│
├── utils/                      # Hjälpfunktioner
│   ├── __init__.py            # Gör utils till Python-modul
│   └── session.py             # Streamlit session state-hantering
│
├── data/                       # Datafiler
│   └── course_summary_full.json  # Chalmers kursinformation (JSON)
│
├── config.py                   # Konfiguration och miljövariabler
├── requirements.txt            # Python-beroenden
├── README.md                   # Denna fil
├── .env                        # Miljövariabler (skapas av användaren)
└── .env.example               # Mall för miljövariabler
```

## Installation

1. **Klona projektet**
```bash
git clone <repo-url>
cd chalmers-course-graph
```

2. **Skapa virtuell miljö**
```bash
python3 -m venv venv
source venv/bin/activate  # På Windows: venv\Scripts\activate
```

3. **Installera dependencies**
```bash
pip install -r requirements.txt
```

4. **Konfigurera miljövariabler**
```bash
cp .env.example .env
```
Redigera `.env` och fyll i:
- `NEO4J_URI`: Din Neo4j databas URI (standard: bolt://localhost:7687)
- `NEO4J_USER`: Din Neo4j användare (standard: neo4j)
- `NEO4J_PASSWORD`: Ditt Neo4j lösenord
- `LITELLM_API_KEY`: Din API-nyckel (se nedan)
- `LITELLM_BASE_URL`: Din base URL (se nedan)
- `LITELLM_MODEL`: LLM-modell att använda (standard: gpt-4)

### LLM-konfiguration

Systemet är byggt för [LiteLLM](https://litellm.ai/) som stödjer 100+ LLM-providers genom ett enhetligt API. Du kan använda:

**Option 1: LiteLLM Proxy (rekommenderat)**
```bash
# Installera LiteLLM
pip install litellm

# Starta proxy med din provider (t.ex. OpenAI)
litellm --model gpt-4 --api_key sk-din-openai-nyckel

# I .env:
LITELLM_BASE_URL=http://localhost:8000
LITELLM_API_KEY=valfri-sträng
LITELLM_MODEL=gpt-4
```

**Option 2: Direkt OpenAI (fungerar också)**
```bash
# I .env:
LITELLM_BASE_URL=https://api.openai.com/v1
LITELLM_API_KEY=sk-din-openai-api-nyckel
LITELLM_MODEL=gpt-4
```

**Option 3: Andra providers**
LiteLLM stödjer Anthropic, Cohere, Hugging Face, Azure, Google Vertex AI, AWS Bedrock m.fl. Se [LiteLLM docs](https://docs.litellm.ai/docs/providers) för konfiguration.

5. **Starta Neo4j**
Se till att din Neo4j databas körs

6. **Placera kursdata**
Placera `course_summary_full.json` i `data/` mappen

7. **Kör applikationen**
```bash
streamlit run src/streamlit_app.py
```

## Huvudfunktioner

### Grafbyggning och visualisering
- **Programbaserad grafbyggning**: Bygg kompletta kunskapsgrafer för hela utbildningsprogram
- **AI-driven konceptextraktion**: Automatisk identifiering av nyckelkoncept från kursbeskrivningar
- **Interaktiv visualisering**: Utforska grafen med avancerade filter och mastery-baserad färgkodning
- **Bildexport**: Ladda ner professionella bilder av din kunskapsgraf
- **Centrerade konceptgrafer**: Hierarkisk layout för tydlig visualisering av konceptrelationer

### AI-stödd studievägledning
- **Tre studievägar**:
  - **Från grunden**: Börja med grundläggande koncept
  - **Kursbaserat**: Följ en specifik kurs struktur
  - **Specifikt koncept**: Fokusera på ett visst koncept
- **Tre instruktionella lägen**:
  - **Sokratisk dialog**: AI guidar genom frågor som leder till djupare förståelse
  - **Guidat lärande**: Strukturerad förklaring med exempel
  - **Direkt bedömning**: Snabb kunskapsmätning med tre olika frågor
- **Intelligent progression**: AI väljer nästa koncept baserat på förutsättningar och mastery
- **Realtidsuppdatering**: Mastery scores uppdateras automatiskt baserat på din förståelse

### Canvas LMS-integration
- **Synkronisera kurser**: Hämta kurser direkt från Canvas LMS
- **Importera moduler**: Ladda ner kursmaterial och filer
- **Chatta med kursmaterial**: AI-driven chat mot dina Canvas-filer
- **Deadline-översikt**: Se alla assignments i en kalendervy
- **Automatisk kategorisering**: Filerna organiseras per kurs och modul

### Alumn & Karriär
- **Jobbannonsmatchning**: Matcha din kunskapsgraf mot jobbkrav
- **Karriärvägsanalys**: Se vad som krävs för olika karriärer
- **Kompetens-gap analys**: Identifiera utvecklingsområden
- **Graf-uppdatering**: Lägg till kompetenser från CV/projekt
- **Kompetensportfölj**: Generera professionell sammanställning
- **Matchning (demo)**: Hitta mentorer, gruppmedlemmar och företag

### Smart träning
- **Automatiska studiesessioner**: AI genererar anpassade uppgifter
- **Tre svårighetsnivåer**: AI väljer optimalt, Grundläggande, Medelvårt eller Avancerat
- **Varierade uppgiftstyper**: MCQ, öppna frågor, problemlösning
- **Progressionsspårning**: Se din utveckling över tid
- **Intelligent anpassning**: Uppgifter baseras på dina svagheter
- **AI-rättning**: Pedagogisk feedback utan poäng eller betyg
- **Efterfråga-chat**: Fortsätt chatta efter att din lösning har rättats
- **Direktval av svårighet**: Välj nivå direkt i dropdown utan extra knappar

### Spaced Repetition för långsiktig memorering
- **Vetenskapligt beprövad metod**: Baserad på Ebbinghaus glömskekurva och SM-2 algoritmen
- **Individanpassad repetition**: Systemet anpassar sig efter din inlärningshastighet
- **Kursfiltrering**: Repetera koncept från specifika kurser eller alla samtidigt
- **Visuell statistik**: Se din retention, svårighetsgrad och dagliga streak
- **Automatisk schemaläggning**: Koncept visas precis när du håller på att glömma dem
- **Översiktlig kalender**: Se kommande repetitioner för de närmaste 30 dagarna

### Analys och progression
- **AI-analys**: Fem analystyper för programstruktur och förbättringsförslag
- **Mastery tracking**: Exponentiellt viktad genomsnittsberäkning (EWMA) för kunskapsspårning
- **Visuell progression**: Se kunskapsutveckling med färgkodning (röd/gul/grön)
- **Kurskopplingar**: Se vilken kurs varje koncept tillhör med fullständig kursinformation
- **Ärliga bedömningar**: Realistiska analyser baserade på faktiska mastery scores

### Pedagogisk grund
- **Forskningsbaserad**: Bygger på Blooms 2-sigma problem och Mastery Learning
- **Transparent bedömning**: Tydliga kriterier och förklarbar AI
- **Individualisering**: Anpassar sig efter varje students kunskapsnivå
- **Teori-flik**: Fullständig pedagogisk bakgrund med vetenskapliga referenser

## Hur systemet fungerar

### Översikt av processen

1. **Programval**: Sök och välj ditt program från Chalmers kursutbud
2. **Kursval**: Välj vilka kurser som ska inkluderas (obligatoriska + valbara)
3. **AI-analys**: AI extraherar koncept och identifierar kopplingar
4. **Grafbyggande**: Systemet skapar en Neo4j-graf med alla relationer
5. **Visualisering**: Interaktiv graf med PyVis och exportmöjligheter

### Detaljerad process för grafbyggande

#### 1. Datainsamling (`course_parser.py`)
- Läser `course_summary_full.json` 
- Extraherar kursinformation för valt program
- Formaterar data för LLM-bearbetning

#### 2. AI-konceptextraktion (`llm_service.py`)

När en kurs läggs till i grafen:

1. **Kursinformation samlas**:
```python
Kurskod: ABC123
Kursnamn: Exempelkurs
Svenskt namn: Exempelkurs på svenska
Poäng: 7.5
Nivå: Second-cycle
Syfte: [kursens syfte]
Lärandemål: [kursens mål]
Innehåll: [kursens innehåll]
Förkunskapskrav: [förkunskaper]
AI Sammanfattning: [AI-genererad sammanfattning]
```

2. **Befintlig graf hämtas**:
```json
{
  "antal_koncept": 50,
  "antal_kurser": 10,
  "kurser": [
    {"kurskod": "MVE030", "namn": "Linjär algebra"},
    ...
  ],
  "koncept": [
    {
      "namn": "Matriser",
      "beskrivning": "Matematiska objekt...",
      "används_i_kurser": ["MVE030"],
      "förutsätter": ["Vektorer"]
    },
    ...
  ]
}
```

3. **LLM analyserar och returnerar**:
```json
[
  {
    "namn": "Konceptnamn",
    "beskrivning": "Beskrivning av konceptet",
    "förutsätter": ["Annat koncept"]
  }
]
```

#### 3. Grafbyggande (`graph_builder.py`)

1. **Kursnod skapas** med all metadata:
   - Svenska och engelska namn
   - År, läsperiod, regel (O/V/X)
   - Syfte, AI-sammanfattning
   
2. **Konceptnoder** skapas eller uppdateras

3. **Relationer** skapas:
   - `INNEHÅLLER`: Kurs → Koncept
   - `FÖRUTSÄTTER`: Koncept → Koncept

4. **Korsanalys** mellan kurser för att hitta ytterligare förutsättningar

## Anpassa AI-prompter

### Huvudprompt för konceptextraktion

**Fil**: `src/llm_service.py`

**Variabel**: `COURSE_GRAPH_PROMPT`

Denna prompt styr hur AI extraherar koncept från kurser. För att ändra:

1. Öppna `src/llm_service.py`
2. Hitta `COURSE_GRAPH_PROMPT = """..."""`
3. Modifiera prompten efter behov

**Viktiga delar av prompten**:
- Regler för konceptextraktion
- JSON-format för output
- Svenska språkkrav
- Fokus på tekniska/akademiska koncept

### Förutsättningsanalys mellan kurser

**Fil**: `src/llm_service.py`

**Variabel**: `PREREQUISITE_ANALYSIS_PROMPT`

Denna prompt analyserar beroenden mellan koncept från olika kurser.

### Anpassa antal koncept

I `COURSE_GRAPH_PROMPT`, ändra:
```
1. Identifiera 5-10 huvudkoncept från kursen
```
till önskat antal.

### Ändra språk

För engelska koncept, ändra:
```
3. Använd svenska för alla namn och beskrivningar
```
till:
```
3. Använd engelska för alla namn och beskrivningar
```

## Grafdatabasstruktur

### Noder

**Kurs**:
```cypher
(:Kurs {
  kurskod: "ABC123",
  namn: "Kursnamn på svenska",
  namn_sv: "Kursnamn på svenska",
  namn_en: "Course name in English",
  beskrivning: "Kort beskrivning",
  syfte: "Fullständigt syfte",
  ai_sammanfattning: "AI-genererad sammanfattning",
  år: 2,
  läsperiod: 3,
  regel: "O",  // O=Obligatorisk, V=Valbar, X=Examensarbete
  poäng: "7,5"
})
```

**Koncept**:
```cypher
(:Koncept {
  id: "uuid-sträng",
  namn: "Konceptnamn",
  beskrivning: "Beskrivning av konceptet",
  mastery_score: 0.0,  // Kunskapsnivå 0.0-1.0
  retention: 1.0,      // Minnesbehållning 0.0-1.0
  difficulty: 0.3,     // Svårighetsgrad 0.1-0.9
  interval: 1,         // Dagar till nästa repetition
  ease_factor: 2.5,    // Multiplikator för intervall
  review_count: 0,     // Antal repetitioner
  last_review: null,   // ISO-datum för senaste repetition
  next_review: null    // ISO-datum för nästa repetition
})
```

### Relationer

- `(Kurs)-[:INNEHÅLLER]->(Koncept)`: Kurs innehåller koncept
- `(Koncept)-[:FÖRUTSÄTTER]->(Koncept)`: Ett koncept förutsätter ett annat

## Användargränssnitt

### Flik 1: Bygg graf
- **Vänster panel**: Programsökning, inställningar och grafstatistik
- **Höger panel**: Kursöversikt grupperad per år och läsperiod
- **Smart kursval**: Obligatoriska kurser (O) förväljs automatiskt
- **Batch-byggning**: Bygg graf för hela program med realtidsuppdateringar
- **Konfigurerbart**: Välj max koncept per kurs (1-30) och språk

### Flik 2: Graf
- **Interaktiv visualisering**: Klicka, dra och zooma i grafen
- **Avancerade filter**:
  - Nodtyp (kurser/koncept/alla)
  - År (1-5) och läsperiod (LP1-4)
  - Specifika kurser via multiselect
  - Markera enskild kurs
- **Mastery-visualisering**: Aktivera för att se kunskapsprogression med färger
- **Bildexport**: Ladda ner professionell bild med vit bakgrund
- **Individuella kursgrafer**: Expanderbara detaljgrafer för varje kurs

### Flik 3: Analys
- **Automatiska AI-insikter**: Genereras direkt vid första besök
- **Fem analystyper**: Progression, konceptspridning, kursberoenden, helhet, förbättringar
- **Konceptanalys**: Detaljerad information om varje koncept med kopplingar
- **Kursberoenden**: Visualisering av hur kurser bygger på varandra

### Flik 4: Progression
- **Mastery scores**: Uppdatera din kunskapsnivå (0.0-1.0) för varje koncept
- **Visuell statistik**: Histogram och top-10 koncept
- **Sökbar lista**: Hitta och uppdatera specifika koncept
- **CSV-export**: Ladda ner din progression för backup

### Flik 5: Teori
- **Pedagogisk bakgrund**: Fullständig översikt av den vetenskapliga grunden
- **Blooms 2-sigma problem**: Hur AI approximerar individuell handledning
- **Mastery Learning**: Implementation och fördelar
- **Kunskapsgrafer**: Visualisering av konceptuella nätverk
- **Forskningsreferenser**: Komplett lista med vetenskapliga källor

### Flik 6: Inställningar
- **Systemprompts**: Se och redigera alla AI-prompts som används i systemet
- **Canvas Chat prompt**: Anpassa AI-assistenten för kursmaterial
- **Alumn-prompts**: Jobbannonsmatchning, karriärvägar, kompetensportfölj
- **Demo-data generatorer**: 
  - Generera mastery scores baserat på antal klarade terminer
  - Generera repetitionsdata för spaced repetition-systemet

### Flik 7: Smart träning
- **Automatiska sessioner**: AI genererar uppgifter baserat på dina svaga områden
- **Svårighetsnivåer**: AI väljer optimalt, Grundläggande, Medelvårt eller Avancerat
- **Uppgiftstyper**: Multiple choice, öppna frågor, problemlösning, kodning
- **Progressionsspårning**: Se din utveckling för varje koncept
- **AI-rättning**: Pedagogisk feedback direkt utan poäng
- **Efterfråga-chat**: Fortsätt chatta efter rättning
- **Lazy loading**: Startar endast när du klickar "Starta smart träning"

### Flik 8: Studera
- **Tre studievägar**: Från grunden, kursbaserat eller specifikt koncept
- **Intelligent konceptval**: AI väljer nästa koncept baserat på förutsättningar
- **Tre instruktionella lägen**:
  - **Sokratisk dialog**: AI guidar genom frågor som leder till djupare förståelse
  - **Guidat lärande**: Strukturerad förklaring med exempel och kontrollfrågor
  - **Direkt bedömning**: Tre olika frågor (definition/tillämpning/analys) med ökande svårighet
- **Realtidsförståelse**: Progress och mastery uppdateras baserat på dina svar

### Flik 9: Repetera
- **Repetera nu**: Gå igenom koncept som behöver repeteras med enkel fråga-svar format
- **Kursfiltrering**: Välj att repetera koncept från specifika kurser
- **Översikt**: Se alla koncept grupperade per kurs med retention och nästa repetition
- **Repetitionskalender**: Visualisering av kommande repetitioner för 30 dagar
- **Personlig anpassning**: Justera inlärningshastighet och glömskefaktor
- **Statistik**: Daglig streak, genomsnittlig retention och personlig glömskekurva

### Flik 10: Canvas
- **API-konfiguration**: Enkel setup med Canvas URL och Access Token
- **Kurslista**: Se alla dina Canvas-kurser med status
- **Modul-synkronisering**: Ladda ner kursmaterial automatiskt
- **Filhantering**: Organiserad mappstruktur per kurs
- **Chat-integration**: Direkt länk till Canvas-chat för varje kurs

### Flik 11: Deadlines
- **Kalendervy**: Månadsöversikt med alla deadlines
- **Filtrering**: Visa endast specifika kurser
- **Detaljvy**: Se uppgiftsbeskrivningar och poäng
- **Statusindikering**: Ej inlämnad, inlämnad, bedömd, sen
- **Lazy loading**: Hämtar data endast vid behov

### Flik 12: Alumn
- **Jobbannonsmatchning**: Matcha kunskapsgraf mot jobbkrav med ärlig bedömning
- **Graf-uppdatering**: Lägg till kompetenser från CV/projekt/certifikat
- **Upskill**: Analysera kurser mot din profil med Chalmers Upskilling Academy
- **Kompetensportfölj**: Generera professionell sammanställning av kunskaper
- **Karriärvägar**: Se vad som krävs för olika karriärer med realistiska tidslinjer
- **Kompetens-gap**: Identifiera utvecklingsområden för olika roller
- **Matchning**: Demo-funktion för att hitta mentorer, gruppmedlemmar och företag

## Utveckling

### Lägga till ny funktionalitet

1. **Ny prompt**: Lägg till i `src/llm_service.py`
2. **Ny grafanalys**: Lägg till i `services/graph_utils.py`
3. **Ny visualisering**: Modifiera `pages/graph.py`
4. **Ny databearbetning**: Utöka `src/course_parser.py`

### Felsökning

**LLM returnerar inga koncept**:
- Kontrollera API-nycklar i `.env`
- Verifiera att kursinformation skickas korrekt
- Testa med enklare prompt
- Kontrollera att LLM-modellen är tillgänglig

**Graf visas inte**:
- Kontrollera Neo4j-anslutning
- Verifiera att noder skapats i databasen
- Kolla browser-konsolen för JavaScript-fel
- Försök med färre kurser först

**Dubbletter av koncept**:
- Systemet förhindrar normalt dubbletter automatiskt
- Om problem uppstår, använd "Rensa graf" och börja om

**Export fungerar inte**:
- Kontrollera att matplotlib och networkx är installerade
- Försök med färre noder om grafen är mycket stor
- Använd filter för att minska grafstorlek
- Bilden genereras som en ren visualisering med vit bakgrund

## Viktiga filer att känna till

- **Prompter**: `src/llm_service.py` - Alla AI-prompter för konceptextraktion och studera
- **Graflogik**: `src/graph_builder.py` - Hur grafen byggs
- **Visualisering**: `pages/graph.py` - Grafvisualiseringen och export
- **Analys**: `pages/analytics.py` - AI-analys och insikter
- **Studera**: `pages/study.py` - AI-stödd studievägledning
- **Smart träning**: `pages/smart_training.py` - Automatiska AI-genererade uppgifter
- **Canvas**: `pages/canvas.py` - Canvas LMS-integration
- **Canvas Chat**: `pages/canvas_chat.py` - AI-chat med kursmaterial
- **Alumn**: `pages/alumn.py` - Karriärfunktioner och analyser
- **Matchning**: `pages/alumn_matching.py` - Demo-matchning mot alumner/företag
- **Repetera**: `pages/repetition.py` - Spaced repetition system
- **Memory Service**: `services/memory_service.py` - Hantering av repetitionslogik
- **Progression**: `pages/progression.py` - Mastery scores
- **Dataparser**: `src/course_parser.py` - Läser kursinformation
- **Konfiguration**: `config.py` - Miljövariabler och inställningar



