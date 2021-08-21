from flask import Flask, request
import pandas as pd
from bs4 import BeautifulSoup
from urllib.request import urlopen, Request
from nltk.sentiment.vader import SentimentIntensityAnalyzer

app = Flask(__name__)


@app.route('/nse_symbols', methods=['GET', 'POST'])
def nse_symbols():
    df = pd.read_csv("https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/APAC/NSE.csv?token=AIZPUXLTDUS5EZS24PHFDFC7TJY4Y")
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")

        cluster = df.loc[df['Symbol'] == symbol].Cluster.values
        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols


@app.route('/osaka_symbols', methods=['GET', 'POST'])
def osaka_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/APAC/Osaka.csv?token=AIZPUXKDNTY7H3MJ5N3KJPC7TJZEC')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/mcx_symbols', methods=['GET', 'POST'])
def mcx_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/APAC/MCX.csv?token=AIZPUXMAKZGKZOT4YZB42FC7TJZCW')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/hkse_symbols', methods=['GET', 'POST'])
def hkse_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/APAC/HKSE.csv?token=AIZPUXJ3LUDOZ6Q73LRGOMC7TJZFM')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/asx_symbols', methods=['GET', 'POST'])
def asx_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/APAC/ASX.csv?token=AIZPUXMAN6HCYYOMCJD6KTC7TJZHG')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/amsterdam_symbols', methods=['GET', 'POST'])
def amsterdam_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/Europe/Amsterdam.csv?token=AIZPUXKWEC7UVWEJKJJIG5C7TKIMY')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/brussels_symbols', methods=['GET', 'POST'])
def brussels_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/Europe/Brussels.csv?token=AIZPUXOCWOPCJ2T4O6IPQO27TKINY')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/lse_symbols', methods=['GET', 'POST'])
def lse_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/Europe/LSE.csv?token=AIZPUXJVL2NODZNYW5DBF727TKIO6')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/lisbon_symbols', methods=['GET', 'POST'])
def lisbon_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/Europe/Lisbon.csv?token=AIZPUXPJLJ4GCTY5QQN3M6S7TKIQM')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/xetra_symbols', methods=['GET', 'POST'])
def xetra_symbols():
    df = pd.read_csv('https://raw.githubusercontent.com/skhiearth/Bullz-and-Bearz-API/main/Clustered/Europe/XETRA.csv?token=AIZPUXLJQBZOPMEX3IYUQ4S7TKIRS')
    symbols = df['Symbol'].to_json()

    if request.method == 'POST':
        symbol = request.args.get("Symbol")
        cluster = df.loc[df['Symbol'] == symbol].Cluster.values

        df_to_send = df.loc[df['Cluster'] == cluster[0]]

        return df_to_send['Symbol'].to_json()

    return symbols

@app.route('/sentiment_analysis', methods=['POST'])
def sentiment_analysis():

    if request.method == 'POST':
        symbol = request.args.get("Symbol")

        n = 3  # the # of article headlines displayed per ticker
        tickers = symbol.split(",")

        # Get Data
        finwiz_url = 'https://finviz.com/quote.ashx?t='
        news_tables = {}

        for ticker in tickers:
            url = finwiz_url + ticker
            req = Request(url=url, headers={'user-agent': 'bullz-and-bearz/0.0.1'})
            resp = urlopen(req)
            html = BeautifulSoup(resp, features="lxml")
            news_table = html.find(id='news-table')
            news_tables[ticker] = news_table

        try:
            for ticker in tickers:
                df = news_tables[ticker]
                df_tr = df.findAll('tr')

                for i, table_row in enumerate(df_tr):
                    a_text = table_row.a.text
                    td_text = table_row.td.text
                    td_text = td_text.strip()
                    if i == n - 1:
                        break
        except KeyError:
            pass

        # Iterate through the news
        parsed_news = []
        for file_name, news_table in news_tables.items():
            for x in news_table.findAll('tr'):
                text = x.a.get_text()
                date_scrape = x.td.text.split()

                if len(date_scrape) == 1:
                    time = date_scrape[0]

                else:
                    date = date_scrape[0]
                    time = date_scrape[1]

                ticker = file_name.split('_')[0]

                parsed_news.append([ticker, date, time, text])

        # Sentiment Analysis
        analyzer = SentimentIntensityAnalyzer()

        columns = ['Ticker', 'Date', 'Time', 'Headline']
        news = pd.DataFrame(parsed_news, columns=columns)
        scores = news['Headline'].apply(analyzer.polarity_scores).tolist()

        df_scores = pd.DataFrame(scores)
        news = news.join(df_scores, rsuffix='_right')

        # View Data
        news['Date'] = pd.to_datetime(news.Date).dt.date

        unique_ticker = news['Ticker'].unique().tolist()
        news_dict = {name: news.loc[news['Ticker'] == name] for name in unique_ticker}

        values = []
        for ticker in tickers:
            dataframe = news_dict[ticker]
            dataframe = dataframe.set_index('Ticker')
            dataframe = dataframe.drop(columns=['Headline'])
            mean = round(dataframe['compound'].mean(), 2)
            values.append(mean)

        df = pd.DataFrame(list(zip(tickers, values)), columns=['Ticker', 'Mean Sentiment'])
        df = df.set_index('Ticker')
        df = df.sort_values('Mean Sentiment', ascending=False)

        return df['Mean Sentiment'].to_json()

if __name__ == '__main__':
    app.run()
