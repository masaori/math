# SageMath 検算: 反復モノイドの主イデアル列

## 対象

**対象ラベル**: `claim_iterate_monoid_tail_is_principal_ideal`

- 併せて検証するラベル: `claim_iterate_monoid_tail_absorbs_composition`、`claim_iterate_monoid_tails_descend`、`claim_iterate_collision_stabilizes_tails`、`claim_iterate_monoid_tail_finite_decidability`
- 検証範囲: 後尾集合 $I_n(F)=\{F^{n+k}\mid k\in\mathbb N\}$ が $F^n$ の生成する主イデアル $\{F^n\circ G\mid G\in P_F\}$ に等しいこと（両包含）、反復写像の合成の吸収、$I_{n+1}(F)\subseteq I_n(F)$、衝突 $F^i=F^j$ 後の安定 $I_n(F)=I_i(F)$（$n\ge i$）、有限代表 $P_F$ の走査による後尾集合の列と最初の安定位置の有限決定
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\le|V|\le3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_tail_is_principal_ideal.sage` | 各 $n$（$0\le n\le j+1$）で $I_n\subseteq\{F^n\circ G\}$ を $H=F^{n+k}=F^n\circ F^k$（加法則）、逆包含を $F^n\circ G=F^n\circ F^k=F^{n+k}$ で一行ずつ検査し、集合の等号を確認。吸収 $G\circ H=F^a\circ F^{n+b}=F^{a+(n+b)}=F^{n+(a+b)}\in I_n$ も一行ずつ検査 | PASS | 769 写像・包含 25,792 行・吸収 54,588 行で成立 |
| `check_tails_descend.sage` | $H=F^{(n+1)+k}=F^{n+(1+k)}$（$\mathbb N$ の結合律）から $H\in I_n$、よって $I_{n+1}\subseteq I_n$ | PASS | 769 写像・14,696 行で成立 |
| `check_collision_stabilizes.sage` | 最初の衝突 $F^i=F^j$、$p=j-i\ge1$、$n\ge i$（有限範囲）で、$I_n\subseteq I_i$ を $F^{n+k}=F^{i+(d+k)}$、$I_i\subseteq I_n$ を以後の周期の $d$ 回適用 $F^{i+k+dp}=F^{i+k}$、$q=k+dp-d\ge0$、$F^{i+k}=F^{i+k+dp}=F^{(i+d)+q}=F^{n+q}$ で一行ずつ検査し、集合の等号を確認 | PASS | 769 写像・17,527 行で成立 |
| `check_finite_decidability.sage` | 有限代表 $P_F$ と合成で走査した $\{F^n\circ G\}$ が定義の $I_n$ と一致し、$I_0,\dots,I_i$ の比較だけで最初の $I_n=I_{n+1}$ が見つかり（$\le i$）、安定前は真部分集合で減少し、$n\ge i$ で新しい後尾集合が現れないこと | PASS | 769 写像・相異なる後尾集合計 1,419 個で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 後尾集合の定義に現れる $k\in\mathbb N$ の全量化は、衝突指数 $j$ を超えると新しい反復写像が現れないことを使い、指数 $n..n+j$ の有限列挙で尽くす。「すべての $n\ge i$」の普遍量化は有限範囲で検査し、普遍的な根拠は人手証明の式変形である。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減と大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-principal-ideal-tail/check_*.sage; do sage "$file"; done
```
