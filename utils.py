import pickle
import tensorflow_hub as hub
import tensorflow_text as tftext
import tensorflow as tf
import numpy as np
from sklearn.decomposition import PCA

model = pickle.load(open("assets/svm_model.pkl", "rb"))
pca_164 = pickle.load(open("assets/pca_164.pkl", "rb"))

preprocess_url = hub.load('https://tfhub.dev/tensorflow/bert_en_uncased_preprocess/3')
encoder_url = hub.load('https://tfhub.dev/tensorflow/bert_en_uncased_L-12_H-768_A-12/4')
bert_preprocess = hub.KerasLayer(preprocess_url)
bert_encoder = hub.KerasLayer(encoder_url)

label_file = open("assets/labels.txt", "r")
label_data = label_file.read()
labels = label_data.replace('\n', ',').split(',')
labels.pop(154)

def make_prediction(text):
    svm_preprocess = bert_preprocess([text])
    svm_encoded = bert_encoder(svm_preprocess)
    svm_encoded_pca = pca_164.transform(svm_encoded['pooled_output'])
    probs = model.predict_proba(svm_encoded_pca)
    top_3 = np.argsort(probs, axis=1)[:,-3:]
    prediction = [labels[top_3[0,2]], labels[top_3[0,1]], labels[top_3[0,0]]]
    return prediction