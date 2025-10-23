program jogoVelhaConsole;
uses
Crt;
const
TAMANHO_TABULEIRO = 3;
type
    Tabuleiro = array[1..TAMANHO_TABULEIRO, 1..TAMANHO_TABULEIRO] of Char;
    procedure Finalizar();
begin
    WriteLn('Pressione qualquer tecla para finalizar!');
    ReadLn;
end;
procedure TrocarSimbolo(var simbolo: Char);
begin
    if simbolo = 'X' then
    simbolo := 'O'
    else
    simbolo := 'X';
end;
procedure InicializarTabuleiro(var tabuleiro: Tabuleiro);
var
i, j: Integer;
begin
    for i := 1 to TAMANHO_TABULEIRO do
begin
    for j := 1 to TAMANHO_TABULEIRO do
begin
    tabuleiro[i, j] := ' ';
end;
end;
end;
procedure ExibirTabuleiro(const tabuleiro: Tabuleiro);
var
i, j: Integer;
begin
ClrScr;
    WriteLn('*********** JOGO DA VELHA ***************');
    WriteLn('********** JoseEmanuelDeLimaAgrela **************');
    WriteLn();
    WriteLn('-------------');
    for i := 1 to TAMANHO_TABULEIRO do
begin
    Write('| ');
    for j := 1 to TAMANHO_TABULEIRO do
    begin
        Write(tabuleiro[i, j], ' | ');
    end;
    WriteLn();
    WriteLn('-------------');
end;
    WriteLn();
end;
    function JogadaValida(const tabuleiro: Tabuleiro; linha, coluna: Integer): Boolean;
begin
    if (linha >= 1) and
    (linha <= TAMANHO_TABULEIRO) and
    (coluna >= 1) and
    (coluna <= TAMANHO_TABULEIRO) and
    (tabuleiro[linha, coluna] = ' ') then
    JogadaValida := True //Result Adequação para compilar no www.onlinegdb.com
else
JogadaValida := False; //Result Adequação para compilar no www.onlinegdb.com
end;
function VerificarVitoria(const tabuleiro: Tabuleiro; simbolo: Char): Boolean;
var
i: Integer;
begin
// Verificar linhas
for i := 1 to TAMANHO_TABULEIRO do
begin
if (tabuleiro[i, 1] = simbolo) and
(tabuleiro[i, 2] = simbolo) and
(tabuleiro[i, 3] = simbolo) then
Exit(True);
end;
// Verificar colunas
for i := 1 to TAMANHO_TABULEIRO do
begin
if (tabuleiro[1, i] = simbolo) and
(tabuleiro[2, i] = simbolo) and
(tabuleiro[3, i] = simbolo) then
Exit(True);
end;
// Verificar diagonais
if (tabuleiro[1, 1] = simbolo) and
(tabuleiro[2, 2] = simbolo) and
(tabuleiro[3, 3] = simbolo) then
Exit(True);
if (tabuleiro[1, 3] = simbolo) and
(tabuleiro[2, 2] = simbolo) and
(tabuleiro[3, 1] = simbolo) then
Exit(True);
VerificarVitoria := False; //Result Adequação para compilar no www.onlinegdb.com
end;
function TabuleiroCompleto(const tabuleiro: Tabuleiro): Boolean;
var
i, j: Integer;
begin
for i := 1 to TAMANHO_TABULEIRO do
begin
for j := 1 to TAMANHO_TABULEIRO do
begin
if tabuleiro[i, j] = ' ' then
Exit(False);
end;
end;
TabuleiroCompleto := True; //Result Adequação para compilar no www.onlinegdb.com
end;
procedure EfetuarJogadaIA(var tabuleiro: Tabuleiro; linha, coluna: Integer);
begin
repeat
linha := Random(TAMANHO_TABULEIRO) + 1;
coluna := Random(TAMANHO_TABULEIRO) + 1;
until JogadaValida(tabuleiro, linha, coluna);
{ Descomente as linhas caso queira deixar sem limpar a tela }
//writeln('Jogada do computador (Jogador O):');
//writeln('Linha: ', linha);
//writeln('Coluna: ', coluna);
tabuleiro[linha, coluna] := 'O';
end;
procedure Jogar(var tabuleiro: Tabuleiro);
var
linha, coluna: Integer;
jogadorAtual: Char;
begin
Randomize;
InicializarTabuleiro(tabuleiro);
jogadorAtual := 'X';
while True do
begin
ExibirTabuleiro(tabuleiro);
if jogadorAtual = 'X' then
begin
WriteLn('*** TERMINAL DE JOGADA ***');
Write('Informe a linha: ');
ReadLn(linha);
Write('Informe a coluna: ');
ReadLn(coluna);
if JogadaValida(tabuleiro, linha, coluna) then
begin
tabuleiro[linha, coluna] := jogadorAtual;
TrocarSimbolo(jogadorAtual);
end
else
begin
WriteLn(UTF8ToString( '*** Jogada inválida! *** '));
WriteLn('ENTER PARA JOGAR NOVAMENTE');
ReadLn;
end;
end
else
begin
WriteLn('Vez do computador (Jogador O):');
EfetuarJogadaIA(tabuleiro, linha, coluna);
TrocarSimbolo(jogadorAtual);
end;
if VerificarVitoria(tabuleiro, 'X') then
begin
ExibirTabuleiro(tabuleiro);
WriteLn(Utf8ToAnsi('Você venceu!'));
Finalizar;
Exit;
end
else if VerificarVitoria(tabuleiro, 'O') then
begin
ExibirTabuleiro(tabuleiro);
WriteLn('O computador venceu!');
Finalizar;
Exit;
end
else if TabuleiroCompleto(tabuleiro) then
begin
ExibirTabuleiro(tabuleiro);
WriteLn('Partida Empatada!');
Finalizar;
Exit;
end;
end;
end;
var
vtabuleiro: Tabuleiro;
begin
Jogar(vtabuleiro);
end.
