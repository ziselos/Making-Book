# Οδηγίες δημιουργίας διαδραστικού βιβλίου χρησιμοποιώντας το PiBook system

--

Το σύστημα προσφέρει την δυνατότητα δημιουργίας-παραγωγής ενός βιβλίου σε μορφή pdf και την επαύξησή του μέσω της εφαρμογής PiBookApp και της αντίστοιχης ιστοσελίδας του βιβλίου.

## Usage and documentation

### Δημιουργία βιβλίου σε μορφή pdf
- Copy or fork book folder 
- Στον φάκελο `book` εισάγουμε τα md αρχεία με το περιεχόμενο του βιβλίου μας. Σβήνουμε τα `file1.md`, `file2.md` και `file3.md`. Προσοχή στα ονόματα των νέων αρχείων, θα πρέπει να είναι αλφαβητικά ταξινομημένα με την σειρά που θέλουμε να εμφανιστούν στο βιβλίο.  
- Τροποποιούμε όπως επιθυμούμε το `style.css` αρχείο στον φάκελο `style`. Αφήνουμε αμετάβλητη την μορφή που εμφανίζεται ο αριθμός σελίδας (πάνω δεξιά και μέσα σε παρενθέσεις) γιατί θα χρησιμοποιηθεί στην συνέχεια από την εφαρμογή **PiBookApp**.  

```javascript
@top-right {    
	...       
    content: "("counter(page)")";
    ...
    }    
```  

- Ανοίγουμε με έναν κειμενογράφο το αρχείο `Makefile` και δίνουμε στην μεταβλητή `bookName` το όνομα του βιβλίου μας `(π.χ bookName = PiBook)`.  
- Εκτελούμε το `Makefile` αρχείο και στον φάκελο `pdf` παίρνουμε το `bookName.pdf`.  
- Εγκαθιστούμε την μηχανή WeasyPrint (for PDF output) σύμφωνα με τις οδηγίες που υπάρχουν [εδώ] (http://weasyprint.readthedocs.io/en/latest/install.html). Προσοχή στην έκδοση του λειτουργικού συστήματος που χρησιμοποιείτε. Ακολουθούμε τα αντίστοιχα βήματα.
- Εκγαθιστούμε το Pandoc (for html export) σύμφωνα με τις [οδηγίες](https://pandoc.org/installing.html)
- Ανοίγουμε με έναν κειμενογράφο το αρχείο `run-MacOS` ή `run-win` αν χρησιμοποιούμε MacOS ή Windows αντίστοιχα και δίνουμε στην μεταβλητή `bookName` το όνομα του βιβλίου μας (π.χ bookName = PiBook). Αν δουλεύουμε σε περιβάλλον Windows, τότε στο αρχείο run-win επιπρόσθετα δηλώνουμε στην θέση των file1.md, file2.md κ.λ.π τα δικά μας md αεχεία.
Εκτελούμε το run-MacOS η run-win αρχείο και στον φάκελο pdf παίρνουμε το bookName.pdf.

### Εξαγωγή πληροφορίας από την ιστοσελίδα του βιβλίου
- Fork book website source files from `https://github.com/mibook/gr`
- Εγκαθιστούμε το `jekyll` ακολουθώντας τα αντίστοιχα βήματα, ανάλογως του λειτουργικού συστήματος που χρησιμοποιούμε (MacOS, Windows, Linux) όπως περιγράφονται [εδώ](https://learn.cloudcannon.com/jekyll/install-jekyll-on-windows/).
- Τρέχουμε το site τοπικά (locally) εκτελώντας κατά σειρά τα εξής βήματα:  
- Ανοίγουμε μια κονσόλα (`terminal`) και μεταφερόμαστε στον ριζικό κατάλογο του τοπικού αποθετηρίου που κάναμε fork. 
- Εκτελούμε την εντολή `bundle exec jekyll serve` ή `bundle exec jekyll serve --host=0.0.0.0` αν θέλουμε σαν default local ip την `0.0.0.0`. Σε περίπτωση εμφάνισης σφάλματος πως λείπει το Gemfile, δημιουργούμε δικό μας. Ανοίγουμε έναν κειμενογράφο και αντιγράφουμε το περιεχόμενο:           
	
	```
   source "https://rubygems.org" 
   gem "github-pages", group: :jekyll_plugins
	```           
	
	Σώζουμε το αρχείο με το όνομα Gemfile στον ριζικό φάκελο.     
      
	-  Σε έναν φυλλομετρητή πληκτρολογούμε `http://localhost:4000` και βλέπουμε το site.

-  <a id="extract-info-from-website"></a> Στον φάκελο `_layouts` δημιουργούμε το αρχείο **galleryApi.html** με την εξής μορφή:    

```
{
    "images": [
    {% for page in site.gallery %}
        {
            "image_url": "{{site.url}}{{ site.urlimg }}{{page.image_url}}",
            "image_thumb_url": "{{site.url}}{{ site.urlimg }}{{page.image_thumb_url}}",
            "title": "{{page.title}}",
            "bookpage": "{{page.bookpage}}",
            "caption": "{{page.caption}}"
        }{% unless forloop.last %},{% endunless %}
    {% endfor %}
    ]
}
```     
Με τον τρόπο αυτό ουσιαστικά εξάγουμε από την ιστοσελίδα σε μορφή json πληροφορία για κάθε εικόνα στον φάκελο `_gallery`. Για την ορθή λειτουργία της PiBookApp είναι απαραίτητα τα πεδία: `image_url`, `title` και `caption`. Είναι σημαντικό να προσέξουμε ποια πεδία θα εισάγουμε, γιατί τα πεδία αυτά υπάρχουν αντίστοιχα στην εφαρμογή PiBookApp στον φάκελο `network\parser\Images` όπως φαίνεται [εδώ](#install-tag)

Δημιουργούμε επίσης στον φάκελο `_layouts`το αρχείο **remixApi.html** με την εξής μορφή:    

```
{
    "remixes": [
    {% for page in site.remix %}
        {
            "title": "{{ page.title }}",
            "codepen": "{{ page.codepen }}",
            "description": "{{page.description}}",
            "bookpage": "{{page.bookpage}}",
            "remix_url": "{{page.remix_url}}"
        }{% unless forloop.last %},{% endunless %}
    {% endfor %}
  ]
}
```   
Το πεδίο bookPage είναι προαιρετικό και μπορεί να παραληφθεί. Για κάθε remix που υπάρχει στον φάκελο `_remix` εξάγουμε σε μορφή json πληροφορία με τα πεδία `title`, `codepen`, `description`, και `remix_url`. Προσθέτουμε ή αφαιρούμε πεδία ανάλογα με τις ανάγκες μας. 

Με τον ίδιο τρόπο δημιουργούμε επίσης στον φάκελο `_layouts` το αρχείο **screeCastsApi.json**

```
{
  "screencasts":[
      {
        "type":"orismosA",
        "videoUrl":"H3ZAjgOi61w"
      },
      {
        "type":"orismosB",
        "videoUrl":"bmJnAo5rWQ"
      },
        {
        "type":"methodosA",
        "videoUrl":"KM6Aakkc-gM"
      },
      {
        "type":"methodosB",
        "videoUrl":"6LI_SH9IE-0"
      },
      {
        "type":"arhetypaA",
        "videoUrl":"gQn5hxRi1U"
      },
      {
        "type":"arhetypaB",
        "videoUrl":"6TSBMZDO64"
      },
      {
        "type":"ergaleiaA",
        "videoUrl":"_FnZVCQFxT4"
      }
      ]
}
```  

Τέλος στον φάκελο `_layouts` δημιουργούμε και το αρχείο pageToServeApi.json όπως παρακάτω:     

```   

{
    "bookPages":[
      {
      "bookImage":"image1",
      "bookPage":"(1)",
      "typeOfContent":"webview.WebviewActivity",
      "content":"Menu pie"
      },
      
      {
      "bookImage":"image2",
      "bookPage":"(3)",
      "typeOfContent":"video.VideoPlayerActivity",
      "content":"orismosA"
      },
      
       {
      "bookImage":"image3",
      "bookPage":"(8)",
      "typeOfContent":"galleryAlternative.GalleryAlterActivity",
      "content":""
      }
      
      ]
  }    
   
``` 
Με τον τρόπο αυτό δηλώνουμε τις σελίδες του φυσικού βιβλίου που θέλουμε να επαυξήσουμε καθώς και τον τύπο επαύξησης. Στο παράδειγμά μας επαυξάνουμε τις σελίδες (1), (3) και (8) με τύπο επαύξησης `webview.WebviewActivity`, `video.VideoPlayerActivity` και `galleryAlternative.GalleryAlterActivity` αντίστοιχα, καθώς και το περιεχόμενο που θα πρέπει να δείξουμε. Τροποποιούμε ανάλογα με τις απαιτήσεις μας τις σελίδες, τον τύπο επαύξησης καθώς και το περιεχόμενο. *Προσοχή* όμως, **δεν αλλάζουμε τα ονόματα των typeOfContent** γιατί χρησιμοποιούνται στην εφαρμογή PiBookApp.  

- Στον φάκελο `pages\collections` προσθέτουμε τα για κάθε ένα αρχείο .html που δημιουργήσαμε στο προηγούμενο βήμα, τα αντίστοιχα md αρχεία με την παρακάτω μορφή:   

**galleryApi.md**

```
---
layout: galleryApi
permalink: "/galleryApi.json"
show_meta: false
header: no
---
```    
**remixApi.md**  

```
---
layout: remixApi
permalink: "/remixApi.json"
show_meta: false
header: no
---
``` 

**screenCastsApi.md**   

```
---
layout: screenCastsApi
permalink: "/screenCastsApi.json"
show_meta: false
header: no
---
```

- Στον φυλλομετρητή γράφω `http://localhost:4000/remixApi.json` και παίρνω απάντηση της μορφής:

```
{
    "remixes": [
    
        {
            "title": "Audio player",
            "codepen": "OyJzZq",
            "description": "SoundCloud Mini player with css record animation",
            "bookpage": "27",
            "remix_url": "http://codepen.io/sckarolos/pen/OyJzZq/"
        },
    
        {
            "title": "Button",
            "codepen": "VvYoLm",
            "description": "Button Concept",
            "bookpage": "",
            "remix_url": "http://codepen.io/sckarolos/pen/VvYoLm/"
        },
    
        {
            "title": "Calculator",
            "codepen": "vOqewJ",
            "description": "Apple's Calculator fork",
            "bookpage": "",
            "remix_url": "http://codepen.io/sckarolos/pen/vOqewJ/"
        },
    
        {
            "title": "Camera motion color",
            "codepen": "VvwXjv",
            "description": "Motion Detection with Javascript Canvas",
            "bookpage": "",
            "remix_url": "http://codepen.io/sckarolos/pen/VvwXjv/"
        }
    ]
 }
```  

<a id="install-tag"></a> Ομοίως για το `http://localhost:4000/galleryApi.json` παίρνουμε σαν αποτέλεσμα

```
{
    "images": [
    
        {
            "image_url": "http://0.0.0.0:4000/images/",
            "image_thumb_url": "http://0.0.0.0:4000/images/",
            "title": "",
            "bookpage": "",
            "caption": ""
        },
    
        {
            "image_url": "http://0.0.0.0:4000/images/adaptive-menus.png",
            "image_thumb_url": "http://0.0.0.0:4000/images/adaptive-menus-thumb.png",
            "title": "adaptive-menus",
            "bookpage": "",
            "caption": "Οι χρήστες προτιμούν τα στατικά μενού ή τα μενού που μπορούν να αλλάξουν μόνοι τους, ενώ δεν προτιμούν ούτε έχουν καλή επίδοση με ένα μενού που αλλάζει αυτόματα ανάλογα με τη συχνότητα χρήσης."
        },
    
        {
            "image_url": "http://0.0.0.0:4000/images/android-emulator.png",
            "image_thumb_url": "http://0.0.0.0:4000/images/android-emulator-thumb.png",
            "title": "android-emulator",
            "bookpage": "",
            "caption": "Ο Android Emulator περιλαμβάνει και μια προσομοίωση κάποιων κουμπιών που συνήθως έχουν τα έξυπνα κινητά."
        }
   ]
}
```
Βλέπουμε στην απάντηση πως οι εικόνες έχουν στο Url τους το πεδίο `0.0.0.0` αν επιλέξουμε να τρέξουμε την ιστοσελίδα με την `bundle exec jekyll serve --host=0.0.0.0`. Αν επιλέξουμε απλά `bundle exec jekyll serve` τότε στο Url θα έχουμε το πεδίο `localhost (127.0.0.1)`.
	
 


### Installation and Configuration of PiBookApp

- Download PiBookApp from [PiBookApp repository](https://github.com/ziselos/PiBookApp)
- Edit file `Definitions.java`. Αντικαθιστούμε τα Jekyll Urls με τα δικά μας

```
//Jekyll Urls
 public final static String LOCALHOST_SOURCE = "current_ip";

 public final static String REPLACE_SOURCE = "current_ip";

 public final static String REPLACE_TARGET = "local_ip"; (same with the one we run jekyll).
```

- Στον φάκελο `res\mipmap` αντικαθιστούμε την εικόνα `ic_title_page` με μια της επιλογής μας. Η εικόνα αυτή θα εμφανίζεται κατά την έναρξη της εφαρμογής.
- Στον φέκελο `network\parser` τροποποιούμε αντίστοιχα τις κλάσεις `Remix` και `Image` προσθέτοντας ή αφαιρώντας αντίστοιχα πεδία. Προσέχουμε όμως τα πεδία στις κλάσεις αυτές να είναι ίδια με αυτά που χρησιμοποιήσαμε για την [εξαγωγή πληροφορίας από την ιστοσελίδα](#extract-info-from-website).  
- Έχοντας αφήσει τα υπόλοιπα ονόματα ίδια, επιλέγουμε στο Android Studio `clean` και στην συνέχεια `run`. Η εκτέλεση πρέπει να γίνει σε αληθινή συσκευή και όχι στον emulator του Android Studio. Φροντίζουμε επίσης **η συσκευή να είναι συνδεδεμένη στο ίδιο δίκτυο με τον υπολογιστή που τρέχουμε το jekyll website**. 
- Η εφαρμογή PiBookApp ανοίγει στην συσκευή και είναι έτοιμη για λειτουργία. Σε περίπτωση *network error*, μιας και δεν θα υπάρχουν σελίδες για επαύξηση, η εφαρμογή εμφανίζει αντίστοιχο μήνυμα σφάλματος και παραμένει στην Splah Screen. 

## Dependencies
Για να χρησιμοποιήσετε το PiBookSystem πρέπει στον υπολογιστή σας να έχετε εγκατεστημένα τα παρακάτω λογισμικά:

- [Android Studio](https://developer.android.com/studio) (for configuration of PiBookApp)

- Έναν καλό κειμενογράφο όπως [Sublime](https://www.sublimetext.com/), [Brackets](http://brackets.io/) or [Atom](https://atom.io/).
