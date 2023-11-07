pipeline {
 agent any
 stages {
 stage('DEVELOPER') {
 steps {
 echo 'INITIAL PHASE STARTS'
 echo 'This is Development PHASE'
 }
 }
 stage('TEST') {
 steps {
 echo 'This is TESTING PHASE'
 }
 }
 stage('QA') {
 steps {
 echo 'This is QUALITY ASSESSMENT PHASE'
 }
 }
 stage('PRE - PRODUCTION'){
 steps{
 echo 'This is PRE - PRODUCTION PHASE'
 }
 stage('PRODUCTION'){
 steps{
 echo 'This is PRODUCTION PHASE'
 echo 'ALL PHASES COMPLETED'
 }
 }
 }
} 
