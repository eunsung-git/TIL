from flask import Flask, render_template, request, url_for

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('나는 수료인가 아닌가.htm')

@app.route('/predict')
def hello():
    ##form 에서 name get 으로 넘어온것 저장
    user = request.args.get("query")
    if user =='김예준' :
        return render_template('김예준.htm')
    elif user =='길상희' :
        return render_template('길상희.htm')
    elif user =='김건우' :
        return render_template('김건우.htm')
    elif user =='김준호' :
        return render_template('김준호.htm')
    elif user =='김효훈' :
        return render_template('김효훈.htm')
    elif user =='박성채' :
        return render_template('박성채.htm')
    elif user =='박소정' :
        return render_template('박소정.htm')
    elif user =='배형미' :
        return render_template('배형미.htm')
    elif user =='신재민' :
        return render_template('신재민.htm')
    elif user =='양용주' :
        return render_template('양용주.htm')
    elif user =='오근우' :
        return render_template('오근우.htm')
    elif user =='유지은' :
        return render_template('유지은.htm')
    elif user =='윤수연' :
        return render_template('윤수연.htm')
    elif user =='윤정우' :
        return render_template('윤정우.htm')
    elif user =='이성천' :
        return render_template('이성천.htm')
    elif user =='이수민' :
        return render_template('이수민.htm')
    elif user =='이윤진' :
        return render_template('이윤진.htm')
    elif user =='이은성' :
        return render_template('이은성.htm')
    elif user =='이의성' :
        return render_template('이의성.htm')
    elif user =='이재현' :
        return render_template('이재현.htm')
    elif user =='차용준' :
        return render_template('차용준.htm')
    elif user =='최서준' :
        return render_template('최서준.htm')
    else:
        return render_template('한영규.htm')

    ##end

    return render_template('result.html', namedata = user)

if __name__ == '__main__':
    app.run()