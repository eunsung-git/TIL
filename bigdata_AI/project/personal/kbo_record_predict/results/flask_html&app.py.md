## personal_proj

### 2020 KBO리그 기록 예측 웹페이지 만들기

#### html 1) mainpage ('p_t')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Let's predict 2020 KBO League!!!</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat;
            align-items:center;}
        img {
            display: block;
            margin: 0px auto;
            vertical-align:middle;}
        div {
		    display : block;
		    margin : 0 auto;}
    </style>
</head>
<body>
    <p>
        <img src="../static/image/sol_kbo_2020_logo.png" width="500" height="500" alt="사진">
    </p>
    <p>
        <div>
            <form action="/p_t" method="get">
                <select name="category_sel">
                    <option selected="selected" value="Category">Category</option>
                    <optgroup label="Pitcher">
                        <option value="p_player">p_player</option>
                        <option value="p_team">p_team</option>
                    </optgroup>
                    <optgroup label="Hitter">
                        <option value="h_player">h_player</option>
                        <option value="h_team">h_team</option>
                    </optgroup>
                </select>
                <br>
                <input type="submit" value="Find" style="submit-align:center" width="20" height="10">
            </form>
        </div>
    </p>
</body>
</html>
```



#### html 2) 투수(p_player) 이름 / 기록 옵션 입력 ('sp')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Let's predict 2020 KBO League!!!</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
		    background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat;}
        div {
		    display : block;
		    margin : 0 auto;}
        img { display: block; margin: 0px auto; }
    </style>
</head>
<body>
    <div>
        <form action="/sp" method="get">
            <input type="text" width="20" height="20" placeholder="Pitcher Name" name="pitcher_name"><br>
            <p><select name="pitcher_record">
                <option selected="selected" value="Record_list">Record_list</option>
                <option value="ERA" name="ERA">ERA(평균자책점)</option>
                <option value="G" name="G">G(경기)</option>
                <option value="W" name="W">W(승리)</option>
                <option value="L" name="L">L(패배)</option>
                <option value="SV" name="SV">SV(세이브)</option>
                <option value="HLD" name="HLD">HLD(홀드)</option>
                <option value="IP" name="IP">IP(이닝)</option>
                <option value="H" name="H">H(피안타)</option>
                <option value="HR" name="HR">HR(홈런)</option>
                <option value="BB" name="BB">BB(볼넷)</option>
                <option value="HBP" name="HBP">HBP(사구)</option>
                <option value="SO" name="SO">SO(삼진)</option>
                <option value="R" name="R">R(실점)</option>
                <option value="ER" name="ER">ER(자책점)</option>
                <option value="WHIP" name="WHIP">WHIP(이닝당 출루허용률)</option>
            </select></p><br>
            <input type='submit' value='Predict'>
        </form>
    </div>
</body>
</html>
```





#### html 3) 투수(p_player) 기록 예측 ('pp')

````html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ pitchername }}_{{pitcherrec}}</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat}
        img {
            display: block;
            margin: 0px auto; }
    </style>
</head>
<body>
    <img src="../static/pred_player/pitcher/{{ pitchername }}{{ pitcherrec }}_2020.png" width="800" height="500" alt="그래프">
</body>
</html>
````



#### html 4) 투수 팀(p_team) 이름 / 기록 옵션 입력 ('st')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Let's predict 2020 KBO League!!!</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background: url("../static/image/logo_bg.png");
            background-repeat: repeat;}
        div {
		    display : block;
		    margin : 0 auto;}
        img { display: block; margin: 0px auto; }
    </style>
</head>
<body>
    <div>
        <form action="/st" method="get">
            <select name="team_name">
                <option selected="selected" value="Team_list">Team_list</option>
                <option value="두산">두산</option>
                <option value="롯데">롯데</option>
                <option value="삼성">삼성</option>
                <option value="키움">키움</option>
                <option value="한화">한화</option>
                <option value="KIA">KIA</option>
                <option value="KT">KT</option>
                <option value="LG">LG</option>
                <option value="NC">NC</option>
                <option value="SK">SK</option>
            </select> <br>
            <select name="team_record">
                <option selected="selected" value="Record_list">Record_list</option>
                <option value="ERA">ERA(평균자책점)</option>
                <option value="G">G(경기)</option>
                <option value="W">W(승리)</option>
                <option value="L">L(패배)</option>
                <option value="SV">SV(세이브)</option>
                <option value="HLD">HLD(홀드)</option>
                <option value="WPCT">WPCT(승률)</option>
                <option value="IP">IP(이닝)</option>
                <option value="H">H(피안타)</option>
                <option value="HR">HR(홈런)</option>
                <option value="BB">BB(볼넷)</option>
                <option value="HBP">HBP(사구)</option>
                <option value="SO">SO(삼진)</option>
                <option value="R">R(실점)</option>
                <option value="ER">ER(자책점)</option>
                <option value="WHIP">WHIP(이닝당 출루허용률)</option>
            </select><br>
            <input type='submit' value='Predict'>
        </form>
    </div>
</body>
</html>
```



#### html 5) 투수 팀(p_team) 기록 예측 ('pt')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ teamname }}_{{teamrec}}</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat}
        img {
            display: block;
            margin: 0px auto; }
    </style>
</head>
<body>
    <img src="../static/pred_team/pitcher/{{ teamname }}_{{ teamrec }}_2020.png" width="800" height="500" alt="그래프">
</body>
</html>
```



#### html 6) 타자(h_player) 이름 / 기록 옵션 입력 ('sh_p')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Let's predict 2020 KBO League!!!</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
		    background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat;}
        div {
		    display : block;
		    margin : 0 auto;}
        img { display: block; margin: 0px auto; }
    </style>
</head>
<body>
    <div>
        <form action="/sh_p" method="get">
            <input type="text" width="20" height="20" placeholder="Hitter Name" name="hitter_name"><br>
            <p><select name="hitter_record">
                    <option selected="selected" value="Record_list2">Record_list2</option>
                    <option value="AVG">AVG(타율)</option>
                    <option value="G">G(경기)</option>
                    <option value="PA">PA(타석)</option>
                    <option value="AB">AB(타수)</option>
                    <option value="R">R(득점)</option>
                    <option value="H">H(안타)</option>
                    <option value="2B">2B(2루타)</option>
                    <option value="3B">3B(3루타)</option>
                    <option value="HR">HR(홈런)</option>
                    <option value="TB">TB(루타)</option>
                    <option value="RBI">RBI(타점)</option>
                    <option value="SAC">SAC(희생번트)</option>
                    <option value="SF">SF(희생플라이)</option>
                </select></p><br>
            <input type='submit' value='Predict'>
        </form>
    </div>
</body>
</html>
```



#### html 7) 타자(h_player) 기록 예측 ('ph_p')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ hittername }}_{{hitterrec}}</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat}
        img {
            display: block;
            margin: 0px auto; }
    </style>
</head>
<body>
    <img src="../static/pred_player/hitter/{{ hittername }}{{ hitterrec }}_2020.png" width="800" height="500" alt="그래프">
</body>
</html>
```



#### html 8) 타자 팀(h_team) 이름 / 기록 옵션 입력 ('sh_t')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Let's predict 2020 KBO League!!!</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background: url("../static/image/logo_bg.png");
            background-repeat: repeat;}
        div {
		    display : block;
		    margin : 0 auto;}
        img { display: block; margin: 0px auto; }
    </style>
</head>
<body>
    <div>
        <form action="/sh_t" method="get">
            <select name="team2_name">
                <option selected="selected" value="Team_list">Team_list</option>
                <option value="두산">두산</option>
                <option value="롯데">롯데</option>
                <option value="삼성">삼성</option>
                <option value="키움">키움</option>
                <option value="한화">한화</option>
                <option value="KIA">KIA</option>
                <option value="KT">KT</option>
                <option value="LG">LG</option>
                <option value="NC">NC</option>
                <option value="SK">SK</option>
            </select> <br>
            <select name="team2_record">
                <option selected="selected" value="Record_list">Record_list</option>
                <option value="AVG">AVG(타율)</option>
                <option value="G">G(경기)</option>
                <option value="PA">PA(타석)</option>
                <option value="AB">AB(타수)</option>
                <option value="R">R(득점)</option>
                <option value="H">H(안타)</option>
                <option value="2B">2B(2루타)</option>
                <option value="3B">3B(3루타)</option>
                <option value="HR">HR(홈런)</option>
                <option value="TB">TB(루타)</option>
                <option value="RBI">RBI(타점)</option>
                <option value="SAC">SAC(희생번트)</option>
                <option value="SF">SF(희생플라이)</option>
            </select><br>
            <input type='submit' value='Predict'>
        </form>
    </div>
</body>
</html>
```



#### html 9) 타자 팀(h_team) 기록 예측 ('ph_t')

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ team2name }}_{{team2rec}}</title>
    <style>
        body {
            width: 500px;
            height: 100px;
            margin-bottom: 15px;
            padding-top: 300px;
            background-image: url("../static/image/logo_bg.png");
            background-repeat: repeat}
        img {
            display: block;
            margin: 0px auto; }
    </style>
</head>
<body>
     <img src="../static/pred_team/hitter/{{ team2name }}_{{ team2rec }}_2020.png" width="800" height="500" alt="그래프">
</body>
</html>
```



#### app.py ) flask 연동

```python
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET'])
def hello_world():
    return render_template('p_t.html')

@app.route('/p_t', methods=['GET'])
def mainpage():
    category_sel = request.args.get("category_sel")
    if category_sel == "p_player":
        return render_template("sp.html")
    elif category_sel == "p_team":
        return render_template("st.html")
    elif category_sel == "h_player":
        return render_template("sh_p.html")
    elif category_sel == "h_team":
        return render_template("sh_t.html")

@app.route('/sp', methods=['GET'])
def pitcher_option():
    pitchername = request.args.get("pitcher_name")
    pitcherrec = request.args.get("pitcher_record")
    return render_template('pp.html', pitchername=pitchername, pitcherrec=pitcherrec)

@app.route('/st', methods=['GET'])
def team_option():
    teamname = request.args.get("team_name")
    teamrec = request.args.get("team_record")
    return render_template('pt.html', teamname=teamname, teamrec=teamrec)

@app.route('/sh_p', methods=['GET'])
def hitter_option():
    hittername = request.args.get("hitter_name")
    hitterrec = request.args.get("hitter_record")
    return render_template('ph_p.html', hittername=hittername, hitterrec=hitterrec)

@app.route('/sh_t', methods=['GET'])
def team2_option():
    team2name = request.args.get("team2_name")
    team2rec = request.args.get("team2_record")
    return render_template('ph_t.html', team2name=team2name, team2rec=team2rec)

if __name__ == '__main__':
    app.run()
```



