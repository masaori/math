# SageMath Check: 和の添字を軌道ごとの置換の組へ取り替えること

## 対象

**対象ラベル**: `def_orbit_restriction_family` / `claim_gluing_restriction_family` /
`claim_restriction_family_gluing` / `claim_shift_char_sum_family`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件と主張 3 件
  （制限の組 $\mathrm{res}(\varphi)$、$\mathrm{gl}(\mathrm{res}(\varphi))=\varphi$、
  $\mathrm{res}(\mathrm{gl}(\alpha))=\alpha$、および
  $\chi_U=\sum_{\alpha\in\mathfrak{A}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\alpha(O))$）
- 併せて使う定義・主張: `def_permutation_sign` / `def_constant_polynomial` /
  `def_second_constant_embedding` / `def_second_matrix` / `def_second_determinant` /
  `def_characteristic_matrix` / `def_characteristic_polynomial` / `def_shift_matrix` /
  `def_row_config_shift` / `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_preserving_permutation` / `def_orbit_restriction` /
  `claim_orbit_restriction_bijective` / `claim_orbit_restriction_determines` /
  `def_orbit_permutation_family` / `def_orbit_gluing` / `claim_orbit_gluing_orbit_preserving` /
  `claim_orbit_gluing_restriction` / `def_orbit_permutation_sign` / `def_orbit_term_factor` /
  `claim_shift_char_sum_orbit_preserving`

### 何を確定させるための検証か

$\chi_U$ を軌道ごとの因子の積へ組み替える道筋の 2 つめの段である。前のセクションで
$\chi_U$ の和は $\mathfrak{S}^{\mathcal{O}}_L$ にわたる和になった。ここではその添字を
軌道ごとの置換の組の全体 $\mathfrak{A}_L$ へ取り替える。取り替えられるのは、
制限を取る写像 $\mathrm{res}$ と貼り合わせ $\mathrm{gl}$ が互いに逆だからである。

1. `def_orbit_restriction_family`。$\varphi\in\mathfrak{S}^{\mathcal{O}}_L$ について
   $\mathrm{res}(\varphi)$ が実際に $\mathfrak{A}_L$ の元であること（各軌道 $O$ で
   $O$ から $O$ への全単射になっていること）を、主張とは別に確かめる。
   **別に見る理由**: 値が $O$ からはみ出していても、あとの等式だけは成り立ちうる。
2. `claim_gluing_restriction_family`。$\mathrm{gl}(\mathrm{res}(\varphi))=\varphi$。
   本文の証明が経由する段（各軌道への制限が一致すること）も別に確かめる。
   **別に見る理由**: 最終の等式だけを見ると、制限が一致していないのに置換としては
   一致している（＝本文の道筋が使えない）場合を見逃す。
3. `claim_restriction_family_gluing`。$\mathrm{res}(\mathrm{gl}(\alpha))=\alpha$。
   こちらも軌道ごとの一致を別に確かめる。
4. `claim_shift_char_sum_family`。本文の式変形の 3 段を**別々に**確かめる。
   最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
   - $\chi_U=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\varphi\!\restriction_O)$
     （前セクションの主張）
   - 和の添字を $\mathfrak{A}_L$ へ取り替えても値が変わらないこと
   - $\mathrm{gl}(\alpha)\!\restriction_O$ を $\alpha(O)$ へ置き換えても値が変わらないこと

あわせて、$\mathfrak{A}_L$ の貼り合わせの全体が $\mathfrak{S}^{\mathcal{O}}_L$ に
ちょうど一致することも見ている（1 対 1 対応そのものの裏取り）。

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-09 の実行では次のとおりであった。

| $L$ | $\lvert\mathcal{O}_L\rvert$ | $\lvert\mathfrak{A}_L\rvert$ | $\lvert\mathfrak{S}^{\mathcal{O}}_L\rvert$ | 零元でない項 |
|---|---|---|---|---|
| 1 | 2 個 | 1 個 | 1 個 | 1 個 |
| 2 | 3 個 | 2 個 | 2 個 | 2 個 |
| 3 | 4 個 | 36 個 | 36 個 | 4 個 |
| 4 | 6 個 | 27648 個 | 走らせていない | 走らせていない |

走らせたすべての $L$ で零元でない項が存在する（上の 4 が $0=0$ を見ているだけではない）。
$L=3$ では $\mathfrak{A}_L$ の 36 項のうち零元でないのは 4 項だけである。
$L=1,2$ では $\mathfrak{A}_L$ の元が 1 個・2 個しかなく、**添字の取り替えが
ほとんど何も動かしていない**（$L=1$ では和が 1 項である）。取り替えが実際に効いているのは
$L=3$ の 36 項と、$\mathrm{res}\circ\mathrm{gl}$ だけで閉じる $L=4$ の 27648 個である。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| $\mathrm{res}(\mathrm{gl}(\alpha))=\alpha$ | $L=1,2,3,4$。$\mathfrak{A}_L$ の全ての元 |
| $\mathrm{res}(\varphi)\in\mathfrak{A}_L$ | $L=1,2,3$ |
| $\mathrm{gl}(\mathrm{res}(\varphi))=\varphi$ | $L=1,2,3$ |
| 1 対 1 対応の突き合わせ | $L=1,2,3$ |
| $\chi_U$ の和の添字の取り替えとその 3 段 | $L=1,2,3$ |

$L=3$ までに限ったものがあるのは、$\mathfrak{S}^{\mathcal{O}}_L$ を $\mathfrak{S}_L$ の
全列挙から絞って作っているためである（$L=4$ では $16!$ 通りになる）。
**軌道ごとの置換から組み立てて $\mathfrak{S}^{\mathcal{O}}_L$ を作ることはしない。**
その組み立てが成り立つことこそ、ここで確かめようとしている対応そのものであり、
前提にすると検証が循環する。$\mathfrak{A}_L$ だけで閉じる
$\mathrm{res}(\mathrm{gl}(\alpha))=\alpha$ は $L=4$ まで走らせた。

### 計算の厳密性

有限集合の元の比較と数え上げ、整数 $-1$ の冪、および $\mathbb{Z}[x][t]$ の有限和と有限積だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$\mathrm{res}(\varphi)$ が組であること・両向きの往復・1 対 1 対応の突き合わせ・$\chi_U$ の和の添字の取り替えとその 3 段） |

```
sage sagemath/check/shift-char-family-sum/check.sage
```
