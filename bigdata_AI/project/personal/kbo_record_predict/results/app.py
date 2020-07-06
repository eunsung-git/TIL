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