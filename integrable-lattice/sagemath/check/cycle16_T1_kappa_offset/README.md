# cycle 16 / T1: 全域木数 $\kappa$ と Monsky の和 $S_n$ のオフセットの厳密確認

スクリプト `kappa_offset.sage`、出力 `kappa_offset.out`（SageMath 10.6、`sage kappa_offset.sage`）。

本体は `outputs/reports/cycle16_T1_monsky_primary_sources.md`。
**本ディレクトリは、論文 001（`structured-latex/content/005_duality.ts` の
双対命題 D 直後の「規約の注意」）に書かれているオフセット式が、
Kataoka arXiv:2606.03579 Proposition 4.4 の原文と食い違っていることを、
数値で（厳密整数計算だけで）確定させるためのものである。定理を証明したのではない。**

## 対象（何を検証したか）

不分岐な $\mathbb{Z}_p^d$-塔（本スクリプトは $d=1$）について、

$$S_n:=\sum_{\substack{\chi\in\widehat{\Gamma_n}\setminus\{1\}}}\mathrm{ord}_p\bigl(\chi(\det L_\alpha)\bigr)$$

と全域木数 $\kappa_{X_n}$ の関係。候補は 2 つある。

- **(K)** $\mathrm{ord}_p(\kappa_{X_n})=S_n-dn+\mathrm{ord}_p(\kappa_X)$
  — Kataoka Proposition 4.4（不分岐の場合。$\mathrm{ord}_p(\#\Gamma_n)=dn$）
- **(P)** $\mathrm{ord}_p(\kappa_{X_n})=S_n-dn+\mathrm{ord}_p(\kappa_X)-\mathrm{ord}_p(\#V_X)$
  — 論文 001 の現行記述

$\#V_X$ が $p$ で割れる基底グラフを入れてあるので、両者は区別できる。

## 手順（どのスクリプトを何の設定で実行したか）

`kappa_offset.sage`（$d=1$）と `kappa_offset_d2.sage`（$d=2$）を実行する。設定はスクリプト内に固定。

**$d=1$（`kappa_offset.sage` → `kappa_offset.out`）**

- 基底グラフ 5 例。うち 3 例は $p\mid\#V_X$（2 頂点 2 重辺／$p=2$、3 頂点閉路／$p=3$、
  4 頂点／$p=2$）、2 例は $p\nmid\#V_X$ の対照（2 頂点 3 重辺／$p=3$、1 頂点ブーケ／$p=3$）。
- $\kappa$ は導来グラフの整数ラプラシアンの既約行列式（Matrix-Tree）で**厳密整数**計算。
- $S_n$ は $\mathrm{Res}_x\bigl((x^{N}-1)/(x-1),\ \det L_\alpha(x)\bigr)$ の $p$ 進付値として
  **厳密整数**計算（$\Gamma_n=\mathbb{Z}/N$、$N=p^n$）。浮動小数点も $\mathbb{Q}_p$ も使わない。
- $n=0,\dots,4$（頂点数 $\le250$ の範囲）。

**$d=2$（`kappa_offset_d2.sage` → `kappa_offset_d2.out`）— 本プロジェクトの実際の設定**

- 基底グラフ 3 例。2 例は $p\mid\#V_X$（2 頂点 3 重辺／4 頂点、いずれも $p=2$）、
  1 例は対照として $L\times L$ トーラスに当たる 1 頂点 2 ループ（$\#V_X=1$）。
- $S_n$ は**導来グラフを一切使わない独立経路**で計算する。円分体 $\mathbb{Q}(\zeta_N)$ の中で
  $\prod_{(j,k)\neq(0,0)}\det L_\alpha(\zeta^j,\zeta^k)$ を厳密に積み、有理整数へ落としてから
  $p$ 進付値を取る（$\kappa$ の計算経路と結果が独立になるようにするため）。
- $n=0,\dots,3$（頂点数 $\le160$ の範囲）。

## 結論（実行ログから読み取れる事実）

| | (K) Kataoka Prop 4.4 形 | (P) 論文 001 現行形 |
|---|---|---|
| $d=1$（25 例） | 不一致 **0** | 不一致 **15** |
| $d=2$（14 例） | 不一致 **0** | 不一致 **7** |

- 不一致はちょうど $\mathrm{ord}_p(\#V_X)>0$ の例に限られ、ずれ幅はちょうど $\mathrm{ord}_p(\#V_X)$ である。
- したがって論文 001 の「規約の注意」にある $-\mathrm{ord}_p(\#V_X)$ の項は**誤り**であり、
  削除すべきである。$L\times L$ トーラス（1 頂点ブーケ）では $\#V_X=1$ のため
  この誤りが数値に現れず、cycle 15 の数値確認では検出できなかった。

**これは既知定理（Kataoka Proposition 4.4）との突合であって、定理の証明ではない。**
（$-\mathrm{ord}_p(\#V_X)$ が消える理由の導出は
`outputs/reports/cycle16_T1_monsky_primary_sources.md` §5.2 にある。）
