---
title: "Model for single exon Copy Number Variant detection in diagnostic"
description : "This is meta description"
type: post
date: 2022-08-19T12:29:40+06:00
image: images/blog/GraphicalAbstractGB.webp
attachments: images/blog/Test.webp
author: Giulia Brunelli
collaborations:
    - image: images/blog/loghi_coll/iit.webp
    - image: images/blog/loghi_coll/siena.webp
---

We set up a computational pipeline based on EXCAVATOR2 for the detection of CNVs in genetics clinical practice. However at the state of the art, we are not able to identify CNVs shorter than 3 exons. Therefore we aim to exploit the distribution of the ratio between the coverage depth of one sample and the mean coverage of a pool of controls to define the prior of a Bayesian model for single-exon CNV calling.